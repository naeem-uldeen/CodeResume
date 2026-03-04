module IsbnVerifier

  VALID_ISBN10_FORMAT = /\A[[:digit:]]{9}[[:digit:]X]\z/
  DIGIT_VALUE = ->(digit) { digit == 'X' ? 10 : digit.to_i }

  def self.valid?(isbn)
    isbn = isbn.delete('-')
    return false unless isbn.match?(VALID_ISBN10_FORMAT)
    isbn.chars.each_with_index.map do |digit, i|
      weight = 10 - i
      DIGIT_VALUE.(digit) * weight
    end.sum.modulo(11).zero?
  end

end
