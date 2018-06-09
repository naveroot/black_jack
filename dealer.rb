require_relative 'player'
class Dealer < Player
  def initialize
    super 'Dealer'
  end

  def tern_choice
    @hand.value < 17 ? 3 : 1
  end
end
