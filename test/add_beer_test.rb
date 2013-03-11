require "test_helper"

class AddBeerTest < MiniTest::Unit::TestCase
  
  def test_add_page_responds_ok
    get '/add'
    assert last_response.ok?
  end

  def test_add_beer_to_data_base
    # the table is empty
    assert_equal 0, Beer.count

    post "/add", room: "1812", email: "me@example.com"

    assert_equal 1, Beer.count
    assert_equal 1812, Beer.first[:room]
    assert_match Regexp.new(Beer.first[:token]), last_response.body
  end

  def test_show_error_when_room_is_not_unique
    Beer.create room: 1812
    post "/add", room: "1812"

    assert_match /error/, last_response.body
  end

  def test_show_error_if_no_email_given
    post "/add", room: 1812

    assert_match /error/, last_response.body
  end

end