# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{rehabilitate}
  s.version = "0.3.16"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jamie van Dyke"]
  s.date = %q{2011-01-26}
  s.default_executable = %q{rehabilitate}
  s.description = %q{Backup stuff}
  s.email = %q{jamie@fearoffish.com}
  s.executables = ["rehabilitate"]
  s.extra_rdoc_files = ["README.mdown", "bin/rehabilitate", "lib/rehabilitate.rb", "lib/rehabilitate/plugin.rb", "lib/rehabilitate/plugins/lzop.rb", "lib/rehabilitate/plugins/postgresql.rb", "lib/rehabilitate/plugins/s3.rb", "lib/rehabilitate/plugins/scp.rb", "lib/rehabilitate/plugins/splitter.rb"]
  s.files = ["Gemfile", "Gemfile.lock", "Manifest", "README.mdown", "Rakefile", "bin/rehabilitate", "lib/rehabilitate.rb", "lib/rehabilitate/plugin.rb", "lib/rehabilitate/plugins/lzop.rb", "lib/rehabilitate/plugins/postgresql.rb", "lib/rehabilitate/plugins/s3.rb", "lib/rehabilitate/plugins/scp.rb", "lib/rehabilitate/plugins/splitter.rb", "rehabilitate.gemspec"]
  s.homepage = %q{https://github.com/fearoffish/rehabilitate}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Rehabilitate", "--main", "README.mdown"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{rehabilitate}
  s.rubygems_version = %q{1.4.1}
  s.summary = %q{Backup stuff}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<commander>, ["~> 4.0.3"])
      s.add_runtime_dependency(%q<pluginfactory>, ["~> 1.0.7"])
      s.add_runtime_dependency(%q<log4r>, ["~> 1.1.8"])
      s.add_runtime_dependency(%q<net-ssh>, ["~> 2.0.23"])
      s.add_runtime_dependency(%q<net-scp>, ["~> 1.0.4"])
      s.add_runtime_dependency(%q<fog>, ["~> 0.3.25"])
      s.add_runtime_dependency(%q<excon>, ["~> 0.4.0"])
    else
      s.add_dependency(%q<commander>, ["~> 4.0.3"])
      s.add_dependency(%q<pluginfactory>, ["~> 1.0.7"])
      s.add_dependency(%q<log4r>, ["~> 1.1.8"])
      s.add_dependency(%q<net-ssh>, ["~> 2.0.23"])
      s.add_dependency(%q<net-scp>, ["~> 1.0.4"])
      s.add_dependency(%q<fog>, ["~> 0.3.25"])
      s.add_dependency(%q<excon>, ["~> 0.4.0"])
    end
  else
    s.add_dependency(%q<commander>, ["~> 4.0.3"])
    s.add_dependency(%q<pluginfactory>, ["~> 1.0.7"])
    s.add_dependency(%q<log4r>, ["~> 1.1.8"])
    s.add_dependency(%q<net-ssh>, ["~> 2.0.23"])
    s.add_dependency(%q<net-scp>, ["~> 1.0.4"])
    s.add_dependency(%q<fog>, ["~> 0.3.25"])
    s.add_dependency(%q<excon>, ["~> 0.4.0"])
  end
end
