module Alphabets

  Alphabet = Data.define(:start, :range) do
    def complete_mask
      (1 << range.count) - 1
    end
  end

  English = Alphabet.new(start: 'a', range: 'a'..'z')
  Russian = Alphabet.new(start: 'а', range: 'а'..'я')
  Greek = Alphabet.new(start: 'α', range: 'α'..'ω')
  Hebrew = Alphabet.new(start: 'א', range: 'א'..'ת')
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
      next mask unless alphabet.range.cover?(letter)
      mask | 1 << letter.ord - alphabet.start.ord
    end
  end

  public

  attr_reader :mask

  def alphabet_complete?
    self.mask == alphabet.complete_mask
  end

end
