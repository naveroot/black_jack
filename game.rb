require_relative 'gui'
require_relative 'dealer'
class Game
  include GUI

  def initialize
    @deck = Deck.new
    @players = []
    @player_name = new_player_name
    @players << Player.new(@player_name) << Dealer.new
    @bank = 0
  end

  def start
    @players.each do |player|
      player.hand.add_cards @deck.pick_a_card(2)
      @bank += player.bet(10)
    end
  end

  def tern
    game_info
  end
end