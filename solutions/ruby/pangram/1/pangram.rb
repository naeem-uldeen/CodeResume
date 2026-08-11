class Pangram

  A = 'a'
  ALPHABET = A..'z'
  ALPHABET_MASK = (1 << 26) - 1 # a–z, one bit per letter
  private_constant :A, :ALPHABET, :ALPHABET_MASK

  def self.pangram?(text)
    new(text).alphabet_complete?
  end

  private

  attr_accessor :text, :mask

  def initialize(text)
    self.text = text.downcase.chars
    # Set a bit for each letter found in the text.
    self.mask = self.text.reduce(0) do |mask, letter|
      next mask unless (ALPHABET).cover?(letter)
      mask | (1 << (letter.ord - A.ord))
    end
  end

  public
  
  def alphabet_complete?
    self.mask == ALPHABET_MASK
  end

end
