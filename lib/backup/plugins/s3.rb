require 'plugin'
require 'fog'

class S3 < Plugin
  def list(options)
    location = parse_upload_string(options.location)
    s3 = setup_fog(location)

    log "Listing bucket contents for #{location[:bucket]}"
    dir = s3.directories.get(location[:bucket])
    backups = dir.files.map(&:key).sort!
    backups.each_with_index do |backup, i|
      say "#{i}: #{prettify(backup)}"
    end
  end

  def upload(options)
    location = parse_upload_string(options.location)
    s3 = setup_fog(location)
    location[:dir] = "#{location[:dir]}/#{options._base_backup_name}"

    log "Creating bucket #{location[:bucket]} if it doesn't exist"
    s3.directories.create(:key => location[:bucket])
    options._backup_files.collect! do |local_file|
      log "Uploading #{local_file}"
      log "   => #{location[:dir]}/#{File.basename(local_file)}"
      s3.put_object(location[:bucket],
                    "#{location[:dir]}/#{File.basename(local_file)}",
                    File.read(local_file), { 'x-amz-acl' => 'private' })
    end
  end

  def download(options)
    log "S3 downloading backup"
    log "Number #{options.number}"

    location = parse_upload_string(options.location)
    s3 = setup_fog(location)
    local_file = ""
    dir = s3.directories.get(location[:bucket])
    backups = dir.files.map(&:key).sort!
    if backups[options.number]
      log "Restoring #{backups[options.number]}"
      restore_key = backups[options.number]
      restore_file = s3.get_object(location[:bucket], restore_key)
      local_file = File.join(options.tmp, restore_key.split("/").last)
      File.open(local_file, 'w') do |file|
        file.puts restore_file.body
      end
    else
      log "Invalid number specified, use --list first to get the id you want to restore"
    end
    options._tmp_files << local_file
    options._backup_files = [local_file]
  end

private

  # access_id:secret_key@bucket/file
  def parse_upload_string(upload_string="")
    location = {}

    if upload_string && !upload_string.empty?
      location[:access_key], remaining = upload_string.split(":")
      location[:secret_id],  remaining = remaining.split("@")
      location[:bucket]                = remaining.split("/").first
      location[:dir]                   = remaining.split("/")[1..-1].join("/")
    else
      # use a ~/.fog file
      fog_config = YAML.load(File.read(File.expand_path("~/.fog")))
      location[:access_key] = fog_config[:default][:aws_access_key_id]
      location[:secret_id]  = fog_config[:default][:aws_secret_access_key]
      location[:bucket]     = fog_config[:default][:bucket]
      location[:dir]        = fog_config[:default][:dir]
    end
    location
  end

  def setup_fog(location)
    Fog::AWS::Storage.new(
        :aws_access_key_id     => location[:access_key],
        :aws_secret_access_key => location[:secret_id]
    )
  end

  def prettify(backup_name)
    env, db, date, file = backup_name.scan(/(.*?)\/(.*?)--(.*?)\/(.*)/).flatten
    "#{env} => #{ DateTime.strptime(date, "%Y-%m-%d_%H-%M").strftime("%Y-%m-%d %H-%M UTC") }"
  end
end
