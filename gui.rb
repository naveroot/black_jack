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

  def game_info
    print 'Ваши карты: '
    player_cards(@player)
    player_value(@player)
    player_cash(@player)
    actions_menu
  end

  def player_cash(player)
    puts "У вас #{player.cash}$"
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

  def actions_menu
    puts '1: Пропустить'
    puts '2: Открыть карты'
    puts '3: Добавить карту' if @player.hand.cards.size < 3
  end
end
