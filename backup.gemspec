# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{backup}
  s.version = "0.3.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jamie van Dyke"]
  s.date = %q{2011-01-05}
  s.default_executable = %q{backup}
  s.description = %q{Backup stuff}
  s.email = %q{jamie@fearoffish.com}
  s.executables = ["backup"]
  s.extra_rdoc_files = ["README.mdown", "bin/backup", "lib/backup.rb", "lib/backup/plugin.rb", "lib/backup/plugins/lister.rb", "lib/backup/plugins/lzop.rb", "lib/backup/plugins/postgresql.rb", "lib/backup/plugins/s3.rb", "lib/backup/plugins/scp.rb", "lib/backup/plugins/splitter.rb"]
  s.files = ["Gemfile", "Gemfile.lock", "Manifest", "README.mdown", "Rakefile", "backup.gemspec", "bin/backup", "lib/backup.rb", "lib/backup/plugin.rb", "lib/backup/plugins/lister.rb", "lib/backup/plugins/lzop.rb", "lib/backup/plugins/postgresql.rb", "lib/backup/plugins/s3.rb", "lib/backup/plugins/scp.rb", "lib/backup/plugins/splitter.rb"]
  s.homepage = %q{https://github.com/fearoffish/rehabilitate}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Backup", "--main", "README.mdown"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{backup}
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Backup stuff}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
