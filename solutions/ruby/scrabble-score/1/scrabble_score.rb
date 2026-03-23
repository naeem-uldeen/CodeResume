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
  private_constant :LETTER_VALUES

  def self.score(word)
    new(word).score
  end

  attr_accessor :word

  def initialize(word)
    self.word = word.upcase
  end

  private

  def calculate_tile_values
    word.each_char.sum do |letter|
      _, points = LETTER_VALUES.find { |letters, _|
        letters.include? letter
      }
      points || 0
    end
  end

  public

  def score
    calculate_tile_values
  end

end
