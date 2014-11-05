require 'rake/testtask'
require 'active_record'
require 'yaml'

Rake::TestTask.new do |t|
  t.libs << 'test'
  t.test_files = FileList['test/**/*.rb']
end

desc "Run tests"
task :default => :test

desc "Run migrations"
task :migrate => :environment do
  ActiveRecord::Migrator.migrate 'db/migrate'
end

task :environment do
  ActiveRecord::Base.establish_connection(YAML::load(File.open('db/config.yml')))
end