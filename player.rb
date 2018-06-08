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

  def bet(sum)
    @cash -= sum
    sum
  end

  def max_cards?
    @hand.size >= 3
  end

  def tern
    puts '1: Пропустить'
    puts '2: Открыть карты'
    puts '3: Добавить карту' if @hand.cards.size < 3
    gets.to_i
  end
end
