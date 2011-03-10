require 'rehabilitate/plugin'
require 'fog'
require 'yaml'

class S3 < Rehabilitate::Plugin
  def list(options)
    location = parse_upload_string(options.location)
    s3 = setup_fog(location)

    log "Listing bucket contents for #{location[:bucket]}"
    dir = s3.directories.get(location[:bucket])
    backups = sorted_backups(dir.files)
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
      if File.size(local_file) > options.split_size
        splitter = Splitter.new
        local_file = splitter.split(local_file, options)
      else
        [local_file]
      end
      local_file.each do |local_file|
        log "Uploading #{local_file}"
        log "   => #{local_file}"
        log %{ s3cmd --config /etc/s3cfg #{options.s3_options} put #{local_file} s3://#{location[:bucket]}/#{location[:dir]}/ }
        log %x{ s3cmd --config /etc/s3cfg #{options.s3_options} put #{local_file} s3://#{location[:bucket]}/#{location[:dir]}/ }
      end
    end
  end

  def download(options)
    log "S3 downloading backup"
    log "Number #{options.number}"

    location = parse_upload_string(options.location)
    s3 = setup_fog(location)
    local_file = ""
    dir = s3.directories.get(location[:bucket])
    backups = sorted_backups(dir.files)
    if backups[options.number]
      log "Restoring #{backups[options.number]}"
      restore_key = backups[options.number]
      output = %x{ s3cmd --config /etc/s3cfg get --recursive --skip-existing s3://#{location[:bucket]}/#{backups[options.number]} #{options.tmp}}
      output.split("\n").each {|f| log f}
    else
      log "Invalid number specified, use --list first to get the id you want to restore"
    end
    backup_files =  Dir.glob("#{options.tmp}/#{backups[options.number].split("/").last}/*")
    log "Joining #{backup_files.size} files..."
    joiner = Splitter.new
    joined = backup_files.size > 1 ? joiner.join(backup_files) : backup_files
    options._tmp_files << joined
    options._backup_files = joined.is_a?(Array) ? joined : [joined]
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
      fog_config = YAML.load(File.read(File.expand_path(ENV['FOG_RC'] || ("~/.fog" if File.exists?("~/.fog")) || "/etc/fog")))
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

  def sorted_backups(backups)
    backups.collect do |f|
      key = f.key
      key.split("/")[0..-2].join("/")
    end.sort.uniq
  end

  def prettify(backup_name)
    env, db, date = backup_name.scan(/(.*?)\/(.*?)--(.*)/).flatten
    "#{env} => #{ DateTime.strptime(date, "%Y-%m-%d_%H-%M").strftime("%Y-%m-%d %H-%M UTC") }"
  end
end
