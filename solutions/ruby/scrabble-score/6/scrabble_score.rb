class Scrabble

  SCORE = {
    'A' => 1, 'N' => 1,
    'B' => 3, 'O' => 1,
    'C' => 3, 'P' => 3,
    'D' => 2, 'Q' => 10,
    'E' => 1, 'R' => 1,
    'F' => 4, 'S' => 1,
    'G' => 2, 'T' => 1,
    'H' => 4, 'U' => 1,
    'I' => 1, 'V' => 4,
    'J' => 8, 'W' => 4,
    'K' => 5, 'X' => 8,
    'L' => 1, 'Y' => 4,
    'M' => 3, 'Z' => 10,
  }
  private_constant :SCORE

  private

  attr_accessor :word

  def initialize word
    self.word = word.upcase.chars
  end

  public

  def score
    word.sum(&SCORE)
  end

  def self.letter_value(letter)
    SCORE.fetch(letter.upcase)
  end

end

# --- Exploration: board multipliers (not covered by the exercise's tests) ---

class Multiplier
  def letter_factor = 1
  def word_factor = 1
end

class DoubleLetterScore < Multiplier
  def letter_factor = 2
end

class TripleLetterScore < Multiplier
  def letter_factor = 3
end

class DoubleWordScore < Multiplier
  def word_factor = 2
end

class TripleWordScore < Multiplier
  def word_factor = 3
end

Placement = Data.define(:letter, :multiplier) do
  def initialize(letter:, multiplier: Multiplier.new)
    super
  end

  def points
    Scrabble.letter_value(letter) * multiplier.letter_factor
  end
end

class Play
  def initialize(placements)
    @placements = placements
  end

  def score
    letter_total = @placements.sum(&:points)
    word_factor  = @placements.map { |p| p.multiplier.word_factor }.reduce(1, :*)
    letter_total * word_factor
  end
end
  
