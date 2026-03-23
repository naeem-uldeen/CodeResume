class Scrabble

  LETTER_VALUES = {
    %w[A E I O U L N R S T] => 1,
    %w[D G]                 => 2,
    %w[B C M P]             => 3,
    %w[F H V W Y]           => 4,
    %w[K]                   => 5,
    %w[J X]                 => 8,
    %w[Q Z]                 => 10
  }

  SCORE = LETTER_VALUES.flat_map { |letters, points|
    letters.product([points])# Array#product returns the Cartesian product
  }.to_h
  # it pairs each element of the receiver with each element of the given array(s).
  # For example:k['A', 'E', 'I'].product([1]) => [['A', 1], ['E', 1], ['I', 1]]
  private_constant :LETTER_VALUES, :SCORE

  private

  attr_accessor :word

  def initialize word
    self.word = word.upcase.chars
  end

  public

  def score
    word.sum { |letter| SCORE[letter] }
  end

end
