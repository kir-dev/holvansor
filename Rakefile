# encoding: UTF-8

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

desc "Cleans the database from too old entries."
task :clean_rooms do

  HOST = ENV['HOST'] || "http://localhost:9292"
  def test?; false end
  $do_not_log = true

  # require stuff for this
  require "rubygems"
  require "bundler/setup"
  require "date"
  require "./config/db"
  require "./config/mail"
  require "./app/models/beer"


  def mail(email, token)
    $message ||= File.read "app/emails/confirmation.txt"
    confirmation_link = HOST + "/confirm/" + token
    body = $message % [confirmation_link, token, HOST + "/remove"]
    Pony.mail to: email, subject: "holvansör szoba megerősítés", body: body
  end

  threads = []

  Beer.all.each do |beer|
    if beer.marked_for_deletion
      beer.delete
    elsif beer.created_at < (DateTime.now - 14).to_time
      beer.marked_for_deletion = true
      beer.save
      threads << Thread.new(beer) { |b| mail b.email, b.token }
    end
  end

  threads.map(&:join)
end