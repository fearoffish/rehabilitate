require 'plugin'
require 'uri'
require 'net/ssh'
require 'net/scp'

class Scp < Plugin
  def upload(options)
    location = parse_upload_string(options.location)
    remote_dir = "#{location[:dir]}/#{options._base_backup_name}"
    log "Connecting to #{location[:host]} with user: #{location[:user]}:#{location[:pass]}"

    options._backup_files.collect! do |local_file|
      remote_file = "#{remote_dir}/#{File.basename(local_file)}"
      log "Uploading '#{local_file}' to '#{remote_file}'"
      Net::SCP.upload!( location[:host], 
                        location[:user], 
                        local_file, 
                        remote_file,
                        :password => location[:pass],
                        :recursive => true )
    end
  end

private

  # e.g. user:pass@ftp.example.com/backup-dir
  def parse_upload_string(upload_string)
    location = {}
    location[:user], remaining = upload_string.split(":")
    location[:pass], remaining = remaining.split("@")
    location[:host] = remaining.split("/").first
    location[:dir]  = remaining.split("/")[1..-1].join("/")
    location
  end
end