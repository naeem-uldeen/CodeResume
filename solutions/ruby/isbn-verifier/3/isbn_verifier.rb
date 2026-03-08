class IsbnVerifier

  VALID_ISBN10_FORMAT = /\A[[:digit:]]{9}[[:digit:]X]\z/
  DIGIT_VALUE = ->(digit) { digit == 'X' ? 10 : digit.to_i }

  def self.valid? isbn
    new(isbn).validate
  end

  private

  attr_accessor :isbn

  def initialize isbn
    self.isbn = isbn.delete '-'
  end

  def checksum
    isbn.each_char.with_index.sum { |digit, i|
      DIGIT_VALUE.(digit) * (10 - i)
    }
  end

  public

  def validate
    isbn.match?(VALID_ISBN10_FORMAT) &&
      checksum.modulo(11).zero?
  end

end
