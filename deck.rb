require_relative 'card'
require_relative 'settings'

class Deck
  include Settings
  attr_accessor :cards

  def initialize
    @cards = []
    generate
    shuffle
  end

  def generate
    SUITS.each do |suit|
      VALUES.each do |value|
        @cards << Card.new(suit, value)
      end
    end
  end

  def shuffle
    @cards.shuffle!
  end

  def pick_a_card(number)
    @cards.pop(number)
  end
end
