require "test_helper"

class HomeTest < MiniTest::Unit::TestCase

  def test_display_nincs_if_theres_no_beer_in_the_house
    get "/"
    assert_match /nincs/i, last_response.body
  end

  def test_display_the_same_room_number_if_theres_only_one
    Beer.create room: 1812

    3.times do
      get "/"
      assert_match /1812/i, last_response.body
    end
  end

end