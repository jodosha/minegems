if defined?(RSpec)
  namespace :rcov do
    RSpec::Core::RakeTask.new(:rspec_aggregate) do |task|
      task.pattern = 'spec/**/*_spec.rb'
      task.rspec_opts = "--format progress"
      task.rcov = true
      task.rcov_opts = "--rails --exclude osx\/objc,spec,gems\/ " +
                       "--aggregate tmp/coverage.data"
    end

    Cucumber::Rake::Task.new(:cucumber_aggregate) do |task|
      task.rcov = true
      task.rcov_opts = "--rails --exclude osx\/objc,gems\/,spec\/,features\/ " +
                       "--aggregate tmp/coverage.data -o 'coverage'"
    end

    task :clean_aggregate do
      rm "tmp/coverage.data" if File.exist?("tmp/coverage.data")
    end

    desc "Run aggregate coverage from rspec and cucumber"
    task :rcov => ["rcov:clean_aggregate",
                   "rcov:rspec_aggregate",
                   "rcov:cucumber_aggregate"]

    desc "Find potentially unused app code"
    Cucumber::Rake::Task.new(:unused) do |task|
      task.rcov = true
      task.rcov_opts = "--rails --exclude osx\/objc,spec,gems\/,features\/ " +
                       "--only-uncovered"
    end

    desc "Find unused cucumber step definitions"
    Cucumber::Rake::Task.new(:steps) do |task|
      task.rcov = true
      task.rcov_opts = "--rails --exclude osx\/objc,spec,gems\/,app\/,lib\/" +
                       "--only-uncovered"
    end
  end

  desc "Run cumulative coverage from rspec and cucumber"
  task :rcov => ["rcov:clean", "rcov:rspec_aggregate", "rcov:cucumber_aggregate"]
end