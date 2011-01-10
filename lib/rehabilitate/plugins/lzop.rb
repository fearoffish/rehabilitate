require 'rehabilitate/plugin'

class Lzop < Plugin
  def compress(options)
    options._backup_files.collect! do |backup_file|
      new_backup_name = "#{backup_file}.tar.lzop"
      log "Compressing files..."
      log "cd #{options.tmp} && tar --use-compress-program=lzop -cf #{new_backup_name} #{backup_file.split("/").last}"
      log %x[cd #{options.tmp} && tar --use-compress-program=lzop -cf #{new_backup_name} #{backup_file.split("/").last}]
      options._tmp_files << new_backup_name
      new_backup_name
    end
  end

  def uncompress(options)
    options._backup_files.collect! do |backup_file|
      new_backup_name = "#{options.tmp}/#{File.basename(backup_file).gsub(".tar.lzop", "")}"
      log "Uncompressing files to #{options.tmp}"
      log %{ cd #{options.tmp} && lzop -dq < #{options._backup_files.first} | tar -xvf - }
      log %x{ cd #{options.tmp} && lzop -dq < #{options._backup_files.first} | tar -xvf - }
      options._tmp_files << new_backup_name
      new_backup_name
    end
  end
end
