require 'rubygems'
require 'rake'
require 'echoe'

Echoe.new('rehabilitate', "0.3.6") do |p|
  p.description     = "Backup stuff"
  p.url             = "https://github.com/fearoffish/rehabilitate"
  p.author          = "Jamie van Dyke"
  p.email           = "jamie@fearoffish.com"
  p.ignore_pattern  = ["tmp/*", "script/*", "testing/*"]
  p.development_dependencies = []
  p.runtime_dependencies = [ 
                     'commander ~>4.0.3', 
                     'pluginfactory ~>1.0.7', 
                     'log4r ~>1.1.8',
                     'net-ssh ~>2.0.23',
                     'net-scp ~>1.0.4',
                     'fog ~>0.3.25' ]
end

Dir["#{File.dirname(__FILE__)}/tasks/*.rake"].sort.each { |ext| load ext }
