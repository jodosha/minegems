namespace :app do
  desc 'Setup the application'
  task :setup do
    require 'fileutils'

    # ENVIROMENT
    puts "\n** Configuring servers.\n"

    ## Foreman
    puts "*** Configuring Foreman."
    FileUtils.cp Rails.root.join('Procfile.example'),
      Rails.root.join('Procfile')

    ## Pow
    puts "*** Configuring Pow."
    FileUtils.ln_sf Rails.root, File.expand_path('~/.pow')
    FileUtils.touch Rails.root.join('tmp/always_restart.txt')

    # DATABASE

    ## Postgres
    puts "\n** Configuring database.\n"
    puts "*** Configuring Postgres: your current UNIX username is being used for connection."

    FileUtils.cp Rails.root.join('config', 'database.yml.example'),
      Rails.root.join('config', 'database.yml')

    ## Setup
    puts "*** Setting up the database."

    pids = %w( db redis mongo ).map do |process|
      Kernel.spawn("foreman start #{process}")
    end
    sleep 4

    Thread.new do
      begin
        Rake::Task['db:setup'].invoke
      rescue Exception => e
        puts "*** [ ERROR ] failed to load the database: #{e.message}"
      end
    end.join

    pids.each do |pid|
      Process.kill('SIGTERM', pid)
    end
  end
end
