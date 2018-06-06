class Player
  attr_reader :name, :cash, :hand

  def initialize(name)
    @name = name
    @cash = 100
    @hand = Hand.new
  end

end