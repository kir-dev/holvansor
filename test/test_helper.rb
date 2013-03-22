ENV['RACK_ENV'] = "test"
$do_not_log = true
$:.unshift File.expand_path(File.join(File.dirname(__FILE__), ".."))

require "minitest/autorun"
require "rack/test"

require "app/app"

class MiniTest::Unit::TestCase
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  alias_method :_original_run, :run

  def run(*args, &block)
    result = nil
    Sequel::Model.db.transaction(:rollback => :always) do
      result = _original_run(*args, &block)
    end
    result
  end

  def create_beer(defaults = {})
    h = {
      email: "me@example.com",
      room: 1812
    }.merge! defaults

    Beer.create h
  end

end