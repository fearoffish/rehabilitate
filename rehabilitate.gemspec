# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rehabilitate/version"

Gem::Specification.new do |s|
  s.name        = "rehabilitate"
  s.version     = Rehabilitate::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jamie van Dyke"]
  s.email       = ["jamie@fearoffish.com"]
  s.homepage    = ""
  s.summary     = %q{Handle backups with a plugin based architecture}
  s.description = %q{Handle backups with a plugin based architecture}

  s.rubyforge_project = "rehabilitate"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency("commander")
  s.add_dependency("pluginfactory")
  s.add_dependency("log4r")
  s.add_dependency("net-ssh")
  s.add_dependency("net-scp")
  s.add_dependency("fog")
end