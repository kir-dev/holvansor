require "sequel"
require "logger"
require "config/config"

if !test? && ENV['DATABASE_URI']
  DB = Sequel.connect ENV['DATABASE_URI']
  DB.loggers << Logger.new($stdout) unless $do_not_log
end

# fall back to in-memory
if not defined? DB
  DB = Sequel.sqlite
  DB.loggers << Logger.new($stdout) unless $do_not_log
end

DB.create_table :beers do
  primary_key :id
  Integer :room, :unique => true
  String :token, :size => 32
  String :email
  TrueClass :marked_for_deletion, :default => false

  DateTime :created_at
end unless DB.table_exists? :beers
