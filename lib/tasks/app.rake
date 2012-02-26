namespace :app do
  desc 'Setup the application'
  task :setup do
    require 'fileutils'

    FileUtils.cp Rails.root.join('config', 'database.yml.example'),
      Rails.root.join('config', 'database.yml')

    puts '** Configuring database: your current username is being used for Postgres connection.'

    Rake::Task['db:setup'].invoke
  end
end
