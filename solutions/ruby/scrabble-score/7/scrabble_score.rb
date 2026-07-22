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

if $PROGRAM_NAME == __FILE__
  puts "--- Running Exploration Tests ---"

  # 1. Test letter values
  puts "Letter value of 'C': #{Scrabble.letter_value('C')} (Expected: 3)"
  puts "Letter value of 'Z': #{Scrabble.letter_value('Z')} (Expected: 10)"

  # 2. Test Placement scores (Letter multipliers)
  double_c = Placement.new(letter: 'C', multiplier: DoubleLetterScore.new)
  triple_t = Placement.new(letter: 'T', multiplier: TripleLetterScore.new)
  normal_a = Placement.new(letter: 'A')

  puts "'C' on Double Letter: #{double_c.points} (Expected: 6)"
  puts "'T' on Triple Letter: #{triple_t.points} (Expected: 3)"

  # 3. Test Play score without word multipliers ("CAT" -> C(3x2) + A(1) + T(1x3) = 10)
  play_1 = Play.new([double_c, normal_a, triple_t])
  puts "Play 1 total score: #{play_1.score} (Expected: 10)"

  # 4. Test Play score with Double Word multiplier
  # "CAT" -> (C(3) + A(1) + T(1)) * 2 = 10
  play_2 = Play.new([
    Placement.new(letter: 'C'),
    Placement.new(letter: 'A'),
    Placement.new(letter: 'T', multiplier: DoubleWordScore.new)
  ])
  puts "Play 2 (Double Word) total score: #{play_2.score} (Expected: 10)"

  # Simple sanity assertions
  raise "Test 1 failed!" unless play_1.score == 10
  raise "Test 2 failed!" unless play_2.score == 10

  puts "✅ All exploration tests passed successfully!"
end
