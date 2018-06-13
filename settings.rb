module Settings
  SUITS = %w[♥ ♦ ♣ ♠].freeze
  VALUES = %w[2 3 4 5 6 7 8 9 10 J Q K A].freeze
  START_CASH = 100
  ERRORS = {
    max_cards: 'В руке слишком много карт!',
    wrong_choice: 'Введите y или n',
    empty_name: 'Имя не может быть пустым!',
    wrong_number: 'Введите корректное число'
  }.freeze
  VIEW_CONFIG = { all:         { cash: true,
                                 dealers_card: true,
                                 dealers_value: true },
                  player_only: { cash: true,
                                 dealers_card: false,
                                 dealers_value: false } }.freeze
end
