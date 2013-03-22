require "rake/testtask"

task :default => :test

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList['test/*_test.rb']
end

namespace :log do

  desc "Clear all log files"
  task :clear do
    exec "rm log/*.log"
  end
  
end