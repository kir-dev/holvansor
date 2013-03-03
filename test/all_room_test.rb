require "test_helper"

class AllRoomTest < MiniTest::Unit::TestCase

  def test_all_room_numbers_are_displayed
    DB[:beer].insert room: 101
    DB[:beer].insert room: 102

    get "/all"
    assert_match /101/, last_response.body
    assert_match /102/, last_response.body
  end
end