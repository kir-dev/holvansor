require "test_helper"

class RemoveBeerTest < MiniTest::Unit::TestCase

  def test_display_error_when_room_does_not_exist
    delete "/remove", room: 1810

    assert last_response.ok?
    assert_match /class=\"error\"/, last_response.body
  end

  def test_display_error_when_verification_token_does_not_match
    DB[:beer].insert room: 100, token: "token"

    delete "/remove", room: 100, token: "not-matching"

    assert last_response.ok?
    assert_match /class=\"error\"/, last_response.body
    assert_equal 1, DB[:beer].count
  end

  def test_remove_room
    DB[:beer].insert room: 100, token: "token"
    
    delete "/remove", room: 100, token: "token"

    assert_equal 302, last_response.status
    assert DB[:beer].empty?
  end

  def test_getting_remove_form
    get "/remove"
    assert last_response.ok?
  end
end
