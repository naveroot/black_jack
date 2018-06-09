require_relative 'settings'
require_relative 'gui'
class Player
  include Settings
  include GUI

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

  def tern_choice
    actions_menu(self)
    choice = gets.to_i
    raise ERRORS[:max_cards] if choice == 3 && @hand.cards.size > 2
    raise ERRORS[:wrong_number] unless choice.between?(1, 3)
    choice
  rescue RuntimeError => error
    puts error.message
    retry
  end
end
