require "test_helper"

class AllRoomTest < MiniTest::Unit::TestCase

  def test_all_room_numbers_are_displayed
    Beer.create room: 201
    Beer.create room: 202

    get "/all"
    assert_match /201/, last_response.body
    assert_match /202/, last_response.body
  end
end