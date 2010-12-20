require 'plugin'

class Splitter < Plugin
  MAX_FILE_SIZE = (4.5*1024*1024*1024*1024*10).to_i #4.5TB

  def join(files)
    log %[ cat #{files.join(" ")} > #{files[0].split("-")[0..-2].join("-")} ]
    log %x[ cat #{files.join(" ")} > #{files[0].split("-")[0..-2].join("-")} ]
    files[0].split("-")[0..-2].join("-")
  end

  def split(file, options)
    log "Splitting file (#{file})"
    split_size = options.split_size || MAX_FILE_SIZE
    log "  => #{split_size} byte pieces"

    log %x{ split -b #{split_size} #{file} #{file}- }
    Dir.glob("#{file}-??")
  end
end