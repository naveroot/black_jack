module Settings
  SUITS = %w[<3 + <> ^].freeze
  VALUES = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze
  START_CASH = 100
  MAX_CARDS = 3
  ERRORS = {
      max_cards: 'В руке слишком много карт!'
  }
end