module GUI
  def greetings
    puts 'Добро пожаловать в игру black-jack'
  end

  def new_player
    error_message = 'Имя не может быть пустым!'
    puts 'Введите свое имя:'
    player_name = gets.chomp
    raise error_message if player_name.nil? || player_name.empty?
    Player.new player_name
  end

  def game_info
    @player.hand.count_value
    puts "Ваши карты: "
    players_hand(@player)
    puts "\nЧисло очков: #{@player.hand.value}"
  end

  def players_hand(player)
    player.hand.cards.each { |card| print "#{card.value}#{card.suit} " }
  end


end