# encoding: UTF-8

require "sequel"
require "securerandom"

class Beer < Sequel::Model

  self.raise_on_save_failure = false
  plugin :validation_helpers

  def validate
    super

    validates_presence [:room, :token]
    validates_includes ROOM_NUMBERS, :room, message: "Nincs ilyen szoba."
    validates_unique :room, message: "A megadott szobában már van sör."
  end

  def before_validation
    self.token ||= SecureRandom.hex
  end

  def self.valid_room_numbers
    rooms = []
    (2..18).each do |floor|
      f = floor * 100

      (1..18).each do |room|
        rooms << f + room
      end
    end
    rooms
  end

  ROOM_NUMBERS = valid_room_numbers.freeze
  
end