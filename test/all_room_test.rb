require "test_helper"

class AllRoomTest < MiniTest::Unit::TestCase

  def test_all_room_numbers_are_displayed
    Beer.create room: 101
    Beer.create room: 102

    get "/all"
    assert_match /101/, last_response.body
    assert_match /102/, last_response.body
  end
end