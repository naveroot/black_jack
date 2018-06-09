require_relative 'gui'
require_relative 'dealer'
require_relative 'settings'
class Game
  include GUI
  include Settings

  def initialize
    @players = []
    border { greetings }
    @player_name = new_player_name
    @players << Player.new(@player_name) << Dealer.new
    @bank = 0
  end

  def start
    until game_over?
      border do
        reset_game
        make_bets
        tern
        open_cards
        select_winner
      end
    end
  end

  protected

  def game_over?
    @players.map(&:bankrupt?).any? || continue?
  end

  def reset_game
    @deck = Deck.new
    @game_over = false
    @players.each do |player|
      player.drop_hand
      player.hand.add_cards @deck.pick_a_card(2)
      @bank += player.bet(10)
    end
  end

  def make_bets
    @players.each do |player|
      @bank += player.bet(10)
    end
  end

  def open_cards
    border do
      game_info VIEW_CONFIG[:all]
    end
  end

  def select_winner
    players_values = @players.map { |player| player.hand.value }
    players_values.select! { |values| values < 22 }
    player_max_value = players_values.max
    winners = @players.select { |player| player.hand.value == player_max_value }
    winner_greetings winners
    take_bank winners
  end

  def take_bank(winners)
    winners.each { |winner| winner.cash += @bank / winners.size }
    @bank = 0
  end

  def tern_over?(player)
    player.hand.value > 21 || @players.map(&:max_cards?).all?
  end

  def player_tern
    @players.each do |player|
      case player.tern_choice
      when 1
        next
      when 2
        @game_over = true
        break
      when 3
        player.hand.add_cards @deck.pick_a_card(1)
      end

      if tern_over?(player)
        @game_over = true
        break
      end
    end
  end

  def tern
    until @game_over
      border { game_info VIEW_CONFIG[:player_only] }
      bank_show
      player_tern
    end
  end
end
