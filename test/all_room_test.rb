require "test_helper"

class AllRoomTest < MiniTest::Unit::TestCase

  def test_all_room_numbers_are_displayed
    create_beer room: 201
    create_beer room: 202

    get "/all"
    assert_match /201/, last_response.body
    assert_match /202/, last_response.body
  end
end