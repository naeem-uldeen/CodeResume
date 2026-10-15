module Hamming
  def self.distance(strand1 : String, strand2 : String) : Int32
    raise StrandLengthError.new unless strand1.size == strand2.size

    strand1.chars.zip(strand2.chars).count do |a, b|
      a != b
    end
  end
end

class StrandLengthError < ArgumentError
  def initialize(message = "DNA strand lengths must be equal")
    super(message)
  end
end
