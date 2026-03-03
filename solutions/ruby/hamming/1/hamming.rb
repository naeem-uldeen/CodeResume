class StrandLengthError < ArgumentError
  def initialize(message = 'Strand lengths must equal')
    super
  end
end

class Hamming

  def self.compute(strand1, strand2)
    new(strand1, strand2).distance
  end

  private

  attr_accessor :nucleotides

  def initialize(strand1, strand2)
    raise StrandLengthError if strand1.size != strand2.size
    self.nucleotides = strand1.chars.zip(strand2.chars)
  end

  public

  def distance
    nucleotides.count { |n1, n2| n1 != n2 }
  end

end