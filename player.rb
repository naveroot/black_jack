require_relative 'settings'
class Player
  include Settings
  attr_reader :name, :hand
  attr_accessor :cash

  def initialize(name)
    @name = name
    @cash = Settings::START_CASH
    @hand = Hand.new
  end

  def buy_back
    @cash = Settings::START_CASH
  end

  def drop_hand
    @hand.clear
  end

  def bet(sum)
    @cash -= sum
    sum
  end

  def max_cards?
    @hand.size >= 3
  end

  def bankrupt?
    @cash.zero?
  end
end
