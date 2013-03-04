require "sequel"
require "logger"

if !test? && ENV['DATABASE_URI']
  DB = Sequel.connect ENV['DATABASE_URI'], :logger => Logger.new($stdout)
end

# fall back to in-memory
if not defined? DB
  DB = Sequel.sqlite
end

DB.create_table :beers do
  primary_key :id
  Integer :room, :unique => true
  String :token, :size => 32
end
