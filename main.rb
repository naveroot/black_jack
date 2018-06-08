require_relative 'player'
require_relative 'card'
require_relative 'deck'
require_relative 'hand'
require_relative 'game'
require_relative 'settings'
require_relative 'gui'

game = Game.new
game.start
game.next_tern
game.open_cards
