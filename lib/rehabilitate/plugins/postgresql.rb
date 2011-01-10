require 'rehabilitate/plugin'

class Postgresql < Plugin
  def backup(options)
    options._backup_files.collect! do |backup_file|
      new_backup_name = "#{backup_file}.sql"
      log "Backing up database #{options.database}"
      log %[pg_dump -h #{options.host} -U #{options.user} #{options.database} > #{new_backup_name}]
      log %x[pg_dump -h #{options.host} -U #{options.user} #{options.database} > #{new_backup_name}]
      options._failure = true if $? == 256
      options._tmp_files << new_backup_name
      new_backup_name
    end
  end

  def restore(options)
    options._backup_files.collect! do |backup_file|
      log "Restoring database #{options.database}"
      drop_table_sql =  File.join(options.tmp, 'droptables.sql')
      log %[psql -t -h #{options.host} -U #{options.user} -d #{options.database} -c "SELECT 'DROP TABLE ' || n.nspname || '.' || c.relname || ' CASCADE;' FROM pg_catalog.pg_class AS c LEFT JOIN pg_catalog.pg_namespace AS n ON n.oid = c.relnamespace WHERE relkind = 'r' AND n.nspname NOT IN ('pg_catalog', 'pg_toast') AND pg_catalog.pg_table_is_visible(c.oid)" > #{drop_table_sql} ]
      log %x[psql -t -h #{options.host} -U #{options.user} -d #{options.database} -c "SELECT 'DROP TABLE ' || n.nspname || '.' || c.relname || ' CASCADE;' FROM pg_catalog.pg_class AS c LEFT JOIN pg_catalog.pg_namespace AS n ON n.oid = c.relnamespace WHERE relkind = 'r' AND n.nspname NOT IN ('pg_catalog', 'pg_toast') AND pg_catalog.pg_table_is_visible(c.oid)" > #{drop_table_sql} ]
      log %[psql -h #{options.host} -U #{options.user} #{options.database} < #{drop_table_sql} ] unless $? == 256
      log %x[psql -h #{options.host} -U #{options.user} #{options.database} < #{drop_table_sql} ] unless $? == 256
      log %[psql -h #{options.host} -U #{options.user} #{options.database} < #{backup_file}] unless $? == 256
      log %x[psql -h #{options.host} -U #{options.user} #{options.database} < #{backup_file}] unless $? == 256
      options._tmp_files << drop_table_sql
      options._failure = true if $? == 256
    end
  end
end
