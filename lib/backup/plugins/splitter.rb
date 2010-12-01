require 'fileutils'

module Backup
  class Splitter
    CHUNK_SIZE = 1024 * 64
    MAX_FILE_SIZE = (4.5*1024*1024).to_i #4.5Mb
    # MAX_FILE_SIZE = (4.5*1024*1024*1024).to_i #4.5GB

    def self.join(input_files, options={})
      input_files = input_files.split
      
      options[:logger].info input_files.inspect
      
      filename = input_files.first.sub(/\.part\d+$/, '')
      options[:logger].info "Files found to join:"
      input_files.each {|f| options[:logger].info "  #{f}" }

      File.open(filename, 'w') do |output|
        sort(input_files).each do |input|
          File.open(input, 'r') do |i|
            while chunk = i.read(CHUNK_SIZE)
              output << chunk
            end
          end

          FileUtils.rm(input) if options[:delete]
        end
      end

      options[:logger].info "Saved to #{filename}"

      [filename]
    end

    def self.sort(input_files)
      input_files.sort {|a,b| part_number(a) <=> part_number(b) }
    end

    def self.part_number(file)
      file[/\.part(\d+)/, 1].to_i
    end

    def self.split(file, options={})
      options[:logger].info "Splitting file (#{file})"
      split_size = options[:size] || MAX_FILE_SIZE
      options[:logger].info "  => #{split_size} byte pieces"
      total_size, part = 0, 0
      files = []
      if split_size > File.size(file)
        options[:logger].info "No need to split, the file is smaller than #{split_size} bytes"
        return [file]
      end
      
      filename = "#{file}.part"
      options[:logger].info "Splitting file: #{file}"
      File.open(File.expand_path(file), 'r') do |i|
        until total_size == File.size(file)
          part += 1
          part_size = 0
          File.open("#{filename}#{part}", 'w') do |o|
            while part_size < split_size && (chunk = i.read([split_size - part_size, CHUNK_SIZE].min))
              part_size += chunk.size
              o << chunk
            end
          end

          total_size += part_size
          print "#{((Float(total_size) / Float(File.size(file))) * 100).to_i}%..."
          STDOUT.flush

          files << "#{filename}#{part}"
        end
      end
      options[:logger].info "Done."

      FileUtils.rm(file) if options[:delete]

      files
    end
  end
end