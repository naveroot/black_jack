require_relative 'gui'
require_relative 'dealer'
require_relative 'settings'
class Game
  include GUI
  include Settings

  def initialize
    @deck = Deck.new
    @players = []
    @player_name = new_player_name
    @players << Player.new(@player_name) << Dealer.new
    @bank = 0
    @open_cards = false
    @game_over = false
    @view_config = { all:         { players: @players,
                                    cash: true,
                                    dealers_card: true,
                                    dealers_value: true },
                     player_only: { players: @players,
                                    cash: true,
                                    dealers_card: false,
                                    dealers_value: false } }
  end

  def start
    @players.each do |player|
      player.hand.add_cards @deck.pick_a_card(2)
      @bank += player.bet(10)
    end
  end

  def open_cards
    @winer = select_winer
    @winer.cash += @bank
    @bank = 0
    border do
      puts "Winer: #{@winer.name}"
      border do
        game_info @view_config[:all]
      end
    end
  end

  def select_winer
    players_by_value = @players.sort_by { |player| player.hand.value }
    players_by_value.select { |player| player.hand.value < 22 }.last
  end

  def game_over?(player)
    p @players.map(&:max_cards?).uniq
    player.hand.value > 21 || @players.map(&:max_cards?).uniq.eql?(true)
  end

  def player_tern
    @players.each do |player|
      case player.tern
      when 1
        next
      when 2
        @game_over = true
        break
      when 3
        player.hand.add_cards @deck.pick_a_card(1)
      end

      if game_over?(player)
        @game_over = true
        break
      end
    end
  rescue StandardError => error
    puts error.message
    retry
  end

  def next_tern
    until @game_over
      border { game_info @view_config[:player_only] }
      bank_show
      player_tern
    end
  end
end
