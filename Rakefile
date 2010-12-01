require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('backup', '0.2.1') do |p|
  p.description     = "Backup stuff"
  p.url             = "https://github.com/fearoffish/rehabilitate"
  p.author          = "Jamie van Dyke"
  p.email           = "jamie@fearoffish.com"
  p.ignore_pattern  = ["tmp/*", "script/*", "testing/*"]
  p.development_dependencies = []
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }
