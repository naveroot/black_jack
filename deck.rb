require_relative 'card'

class Deck
  SUITS = %i[hearts diamonds clubs spaders].freeze
  VALUES = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze
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
