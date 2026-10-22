module IsbnVerifier
  
  def self.valid?(isbn : String) : Bool
    Isbn.new(isbn).valid?
  end
  
end

class Isbn
  
  FORMAT = /^\d{9}[\dX]$/

  getter digits

  def initialize(text : String)
    @digits = text.delete("-")
  end

  def valid? : Bool
    return false unless @digits.matches?(FORMAT)

    checksum =
      @digits.chars.each_with_index.sum do |char, index|
        value = char == 'X' ? 10 : char.to_s.to_i
        value * (10 - index)
      end

    checksum % 11 == 0
  end
  
end
