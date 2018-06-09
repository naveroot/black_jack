require_relative 'settings'
module GUI
  def greetings
    puts 'Добро пожаловать в игру black-jack'
  end

  def winner_greetings(players)
    print "Победитель "
    players.each { |player| print player.name.to_s + ' ' }
    puts "забирает банк #{@bank}$"
  end

  def new_player_name
    error_message = 'Имя не может быть пустым!'
    puts 'Введите свое имя:'
    player_name = gets.chomp
    raise error_message if player_name.nil? || player_name.empty?
    player_name
  end

  def border
    puts '======================================'
    yield if block_given?
    puts '======================================'
  end

  def continue?
    puts 'Хотите продолжить? (y/n)'
    choice = gets.chomp
    # raise ERRORS[:wrong_choice] if choice != 'y' || choice != 'n'
    choice != 'y'
    # rescue StandardError => error
    #   puts error.message
    #   retry
  end

  def bank_show
    puts "В банке: #{@bank}$"
  end

  def game_info(players: @players,
                cash: true,
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
  end

  def press_any_key
    print 'Press ENTER to continue'
    gets
  end
end
