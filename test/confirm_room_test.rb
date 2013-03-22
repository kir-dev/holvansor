# encoding: UTF-8
require "test_helper"

class ConfirmRoomTest < MiniTest::Unit::TestCase

  def test_confirmation_of_room
    b = Beer.create room: 312, email: "me@example.com", marked_for_deletion: true

    get "/confirm/" + b.token

    refute Beer[b.id].marked_for_deletion
    assert_match Regexp.new(b.room.to_s), last_response.body
  end

  def test_confirmation_when_given_token_not_exists
    get "/confirm/" + SecureRandom.hex

    assert last_response.ok?
    assert_match /Érvénytelen token/, last_response.body
  end
end