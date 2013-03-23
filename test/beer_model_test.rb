require "test_helper"

class BeerModelTest < MiniTest::Unit::TestCase
  
  def test_beer_have_to_have_a_room
    b = Beer.new
    refute b.valid?
  end

  def test_beer_room_must_be_actually_a_room_in_sch
    b1 = Beer.new room: 10, email: "me@a.com" # invalid room
    b2 = Beer.new room: 202, email: "me@a.com" # valid room

    refute b1.valid?
    assert b2.valid?
  end

  def test_room_number_must_be_unique
    room_number = 202
    create_beer room: room_number
    
    beer = Beer.new room: room_number, email: "me@a.com"
    refute beer.valid?
  end

  def test_email_must_be_valid
    b1 = Beer.new room: 202, email: "mea.com" # invalid email
    b2 = Beer.new room: 202, email: "me@a.com" # valid email

    refute b1.valid?
    assert b2.valid?

  end
end