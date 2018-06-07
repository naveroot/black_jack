require_relative 'gui'
class Game
  include GUI
  def initialize
    @deck = Deck.new
    @player = new_player
    @dealer = Player.new 'Dealer'

    @player.hand.cards << @deck.pick_a_card(2)
    game_info

  end
end