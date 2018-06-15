require_relative 'dealer'
require_relative 'settings'
class Game
  include Settings

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

  def player_turn
    @players.each do |player|
      case player.turn_choice
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

  def greetings
    puts 'Добро пожаловать в игру black-jack'
  end

  def winner_greetings(players)
    players.size > 1 ? draw(players) : one_winner(players)
  end

  def draw(players)
    print 'Ничья! '
    players.each { |player| print player.name.to_s + ' ' }
    puts 'делят банк между собой'
  end

  def one_winner(players)
    print 'Победитель '
    players.each { |player| print player.name.to_s + ' ' }
    puts "забирает банк #{@bank}$"
  end

  def game_over
    border { puts '    Game Over    ' }
  end

  def new_game?
    puts 'Начать новую игру? y/n'
    choice = gets.chomp
    raise Settings::ERRORS[:wrong_choice] unless %w[y n].include? choice
    choice == 'y'
  rescue RuntimeError => error
    puts error.message
    retry
  end

  def new_player_name
    puts 'Введите свое имя:'
    player_name = gets.chomp
    raise Settings::ERRORS[:empty_name] if player_name.nil? || player_name.empty?
    player_name
  rescue RuntimeError => error
    puts error.message
    retry
  end

  def border
    puts '======================================'
    yield if block_given?
    puts '======================================'
  end

  def continue?
    puts 'Хотите продолжить? y/n'
    choice = gets.chomp
    raise Settings::ERRORS[:wrong_choice] unless %w[y n].include? choice
    choice == 'n'
  rescue RuntimeError => error
    error.message
    retry
  end

  def bank_show
    puts "В банке: #{@bank}$"
  end

  def game_info(cash: true,
                dealers_card: false,
                dealers_value: false)
    @players.each do |player|
      print "Карты #{player.name}: "
      player_cards(player, !player.is_a?(Dealer) || dealers_card)
      player_value(player, !player.is_a?(Dealer) || dealers_value)
      player_cash(player, cash)
    end
  end

  def player_cash(player, show_cash = true)
    puts "Кэш: #{show_cash ? player.cash : '??'}$"
  end

  def player_value(player, show_value = true)
    puts "\nЧисло очков: #{show_value ? player.hand.value : '?'}"
  end

  def player_cards(player, show_cards = true)
    if show_cards
      player.hand.cards.each { |card| print "#{card.value}#{card.suit} " }
    else
      player.hand.cards.size.times { print '?? ' }
    end
  end

  def actions_menu(player)
    puts '1: Пропустить'
    puts '2: Открыть карты'
    puts '3: Добавить карту' if player.hand.cards.size < 3
    gets.to_i
  end

  def press_any_key
    print 'Press ENTER to continue'
    gets
  end
end
