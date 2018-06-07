require_relative 'settings'

class Hand
  include Settings
  attr_accessor :cards, :value

  def initialize
    @cards = []
    @value = 0
  end

  def sort_by_value
    @cards.flatten!.sort_by! do |card|
      VALUES.index(card.value)
    end
  end

  def count_value
    sort_by_value
    @value = 0
    @cards.each do |card|
      @value += card.points @value
    end
  end
end
