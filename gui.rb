module GUI
  def greetings
    puts 'Добро пожаловать в игру black-jack'
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

  def game_info(player)
    viability  = player.is_a?(Dealer) ? false : true
      print "Карты #{player.name}: "
      player_cards(player, viability)
      player_value(player, viability)
      player_cash(player)
  end

  def player_cash(player)
    puts "Кэш: #{player.cash}$"
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
end
