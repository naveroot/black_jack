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

  def turn_choice
    puts '1: Пропустить'
    puts '2: Открыть карты'
    puts '3: Добавить карту' if @hand.cards.size < 3
    choice = gets.to_i
    raise ERRORS[:max_cards] if choice == 3 && @hand.cards.size > 2
    raise ERRORS[:wrong_number] unless choice.between?(1, 3)
    case choice
    when 1
      return :skip_turn
    when 2
      return :open_cards
    when 3
      return :add_card
    end
  rescue RuntimeError => error
    puts error.message
    retry
  end
end
