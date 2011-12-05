require 'rehabilitate/plugin'

class Splitter < Rehabilitate::Plugin
  MAX_FILE_SIZE = (4.5*1024*1024*1024*1024*10).to_i #4.5TB

  def join(files)
    base_file = files.first.match(/(.*)-.*/)[1]
    log %[ cat #{base_file}-[aa-zz] > #{base_file} ]
    log %x[ cat #{base_file}-[aa-zz] > #{base_file} ]
    base_file
  end

  def split(file, options)
    log "Splitting file (#{file})"
    split_size = options.split_size || MAX_FILE_SIZE
    log "  => #{split_size} byte pieces"

    log %x{ split -b #{split_size} #{file} #{file}- }
    split_files = Dir.glob("#{file}-??")
    options._tmp_files << split_files
    split_files
  end
end