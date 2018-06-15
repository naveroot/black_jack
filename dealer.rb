require_relative 'player'
class Dealer < Player
  def initialize
    super 'Dealer'
  end

  def turn_choice
    @hand.value < 17 ? :add_card : :skip_tern
  end
end
