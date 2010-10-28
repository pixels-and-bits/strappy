require 'cucumber/rake/task'

namespace :rcov do
  desc "Run cucumber with RCov"
  task :cucumber do |t|
    rm "coverage.data" if File.exist?("coverage.data")
    Rake::Task["rcov:cucumber_run"].invoke
  end

  Cucumber::Rake::Task.new(:cucumber_run) do |t|
    t.rcov = true
    t.rcov_opts = %w{--rails --text-summary --exclude osx\/objc,gems\/,spec\/,features\/ --aggregate coverage.data}
    t.rcov_opts << %[-o "coverage"]
  end
end
