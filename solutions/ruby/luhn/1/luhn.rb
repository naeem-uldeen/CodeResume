module Luhn

  VALID_LUHN_FORMAT = /\A[[:digit:]]+\z/
  DOUBLE_AND_REDUCE = ->(digit) { (digit * 2).then { |d| d > 9 ? d - 9 : d } }

  def self.valid?(number)
    number = number.delete(' ')
    return false unless number.match?(VALID_LUHN_FORMAT) && number.size >= 2

    number.chars.reverse.each_with_index.map do |digit, i|
      value = digit.to_i
      i.odd? ? DOUBLE_AND_REDUCE.(value) : value
    end.sum.modulo(10).zero?
  end

end
