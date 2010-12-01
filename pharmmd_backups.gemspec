# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{pharmmd_backups}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.2") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jamie van Dyke"]
  s.date = %q{2010-11-29}
  s.description = %q{Backup stuff}
  s.email = %q{jamie.vandyke@pharmmd.com}
  s.executables = ["aws", "backup"]
  s.extra_rdoc_files = ["README.mdown", "bin/aws", "bin/backup", "lib/backup.rb", "lib/backup/plugin.rb", "lib/backup/plugins/lister.rb", "lib/backup/plugins/lzop.rb", "lib/backup/plugins/postgresql.rb", "lib/backup/plugins/s3.rb", "lib/backup/plugins/scp.rb", "lib/backup/plugins/splitter.rb"]
  s.files = ["Gemfile", "Gemfile.lock", "Manifest", "README.mdown", "Rakefile", "backup.gemspec", "bin/aws", "bin/backup", "lib/backup.rb", "lib/backup/plugin.rb", "lib/backup/plugins/lister.rb", "lib/backup/plugins/lzop.rb", "lib/backup/plugins/postgresql.rb", "lib/backup/plugins/s3.rb", "lib/backup/plugins/scp.rb", "lib/backup/plugins/splitter.rb", "pharmmd_backups.gemspec"]
  s.homepage = %q{http://github.com/pmdgithub/pharmmd-backups}
  s.rdoc_options = ["--line-numbers", "--inline-source", "--title", "Pharmmd_backups", "--main", "README.mdown"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{pharmmd_backups}
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
