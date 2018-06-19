require_relative 'dealer'
require_relative 'settings'
require_relative 'gui'
class Game
  include Settings
  include GUI

  def initialize
    @players = []
    border { greetings }
    @player_name = new_player_name
    @players << Player.new(@player_name) << Dealer.new
    @bank = 0
  end

  def start
    while new_game?
      loop do
        game_circle
        break if game_over?
      end
      @players.each(&:buy_back)
    end
  end

  protected

  def game_circle
    border do
      reset_game
      make_bets
      turn
      open_cards
      select_winner
    end
  end

  def game_over?
    @players.map(&:bankrupt?).any? || continue?
  end

  def reset_game
    @deck = Deck.new
    @game_over = false
    @players.each do |player|
      player.drop_hand
      player.hand.add_cards @deck.pick_a_card(2)
    end
  end

  def make_bets
    @players.each do |player|
      @bank += player.bet(10)
    end
  end

  def turn
    until @game_over
      border { game_info VIEW_CONFIG[:player_only] }
      bank_show
      player_turn
    end
  end

  def turn_choice(player)
    case actions_menu(player)
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

  def player_turn
    @players.each do |player|
      case player_choice(player)
      when :skip_turn
        next
      when :open_cards
        @game_over = true
        break
      when :add_card
        player.hand.add_cards @deck.pick_a_card(1)
      else
        raise Settings::ERRORS[:wrong_argument]
      end

      if turn_over?(player)
        @game_over = true
        break
      end
    end
  end

  def player_choice(player)
    if player.is_a? Dealer
      player.hand.value < 17 ? :add_card : :skip_turn
    else
      turn_choice(player)
    end
  end

  def turn_over?(player)
    player.hand.value > 21 || @players.map(&:max_cards?).all?
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
end
