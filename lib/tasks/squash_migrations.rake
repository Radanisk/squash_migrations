desc 'Squash migrations'
task :squash_migrations => :environment do
  Rake::Task['db:migrate'].invoke
  migration_proxies = ActiveRecord::Migrator.migrations(ActiveRecord::Migrator.migrations_path)
  last_migration_proxy = migration_proxies.last
  migration_proxies = migration_proxies.take(migration_proxies.size - 1)
  migration_proxies.each do |migration_proxy|
    File.delete(migration_proxy.filename)
  end

  FileUtils.copy('db/schema.rb', last_migration_proxy.filename)
end