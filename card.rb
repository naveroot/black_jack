class Card
  attr_reader :suit, :value
  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def ace?
    @value == 'A'
  end

  def ace_value(points)
    points > 9 ? 1 : 11
  end

  def points(points)
    if ace?
      ace_value points
    elsif @value.to_i > 0
      @value.to_i
    else
      10
    end
  end
end
