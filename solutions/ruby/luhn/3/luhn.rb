class Luhn

  VALID_LUHN_FORMAT = /\A[[:digit:]]+\z/
  DOUBLE_AND_REDUCE = ->(digit) do (digit * 2)
    .then { |d| d > 9 ? d - 9 : d }
  end

  def self.valid?(number)
    new(number).validate
  end

  private

  attr_accessor :number, :valid_size

  def initialize(number)
    self.number = number.delete(' ')
    self.valid_size = self.number.size >= 2
  end

  def checksum
    number.chars.reverse.each_with_index.sum do |digit, i|
      value = digit.to_i
      i.odd? ? DOUBLE_AND_REDUCE.(value) : value
    end
  end

  public

  def validate
    valid_size &&
      number.match?(VALID_LUHN_FORMAT) &&
      checksum.modulo(10).zero?
  end

end
