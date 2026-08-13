module Alphabets

  module English
    START = 'a'
    RANGE = START..'z'
    COMPLETE_MASK = '11111111111111111111111111'.to_i(2)
  end

  module Russian
    START = 'а'   # U+0430
    RANGE = START..'я'  # U+0430..U+044F
    COMPLETE_MASK = ('1' * 32).to_i(2)
  end
  
end

class Pangram

  DEFAULT_ALPHABET = Alphabets::English
  private_constant :DEFAULT_ALPHABET

  def self.pangram?(text, alphabet = DEFAULT_ALPHABET)
    new(text, alphabet).alphabet_complete?
  end

  private

  attr_accessor :text, :alphabet
  attr_writer :mask

  def initialize(text, alphabet = DEFAULT_ALPHABET)
    self.text = text.downcase.chars
    self.alphabet = alphabet
    self.mask = self.text.reduce(0) do |mask, letter|
      next mask unless alphabet::RANGE.cover?(letter)
      mask | 1 << letter.ord - alphabet::START.ord
    end
  end

  public

  attr_reader :mask

  def alphabet_complete?
    self.mask == alphabet::COMPLETE_MASK
  end

end
