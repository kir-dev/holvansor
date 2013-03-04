require "test_helper"

class AddBeerTest < MiniTest::Unit::TestCase
  
  def test_add_page_responds_ok
    get '/add'
    assert last_response.ok?
  end

  def test_add_beer_to_data_base
    # the table is empty
    assert_equal 0, Beer.count

    post "/add", room: "1812"

    assert_equal 1, Beer.count
    assert_equal 1812, Beer.first[:room]
    assert_match Regexp.new(Beer.first[:token]), last_response.body
  end
end