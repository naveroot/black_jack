require_relative 'player'
require_relative 'card'
require_relative 'deck'
require_relative 'hand'
require_relative 'game'
require_relative 'settings'
require_relative 'gui'

game = Game.new
game.start
game.tern
# hand = Hand.new
# deck = Deck.new
# hand.cards << deck.pick_a_card(4)
# p hand
# hand.count_value
# p hand.value