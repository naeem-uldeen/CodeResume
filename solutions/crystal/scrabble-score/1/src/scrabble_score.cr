class ScrabbleScore

  private LETTER_VALUES = {
    ['A','E','I','O','U','L','N','R','S','T'] => 1,
    ['D','G']                                 => 2,
    ['B','C','M','P']                         => 3,
    ['F','H','V','W','Y']                     => 4,
    ['K']                                     => 5,
    ['J','X']                                 => 8,
    ['Q','Z']                                 => 10
  }

  def self.score(word : String) : Int32
    new(word).score
  end

  private property word : String

  private def initialize(word : String)
    @word = word.upcase
  end

  private def letter_value(letter : Char) : Int32
    LETTER_VALUES.find { |letters, _|
      letters.includes?(letter)
    }.try(&.[1]) || 0
  end

  def score : Int32
    word.chars.sum { |letter| letter_value(letter) }
  end

end
