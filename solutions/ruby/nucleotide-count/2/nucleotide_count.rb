Nucleotide = ->(dna_strand) {

  dna_strand.chars.each_with_object({'A' => 0, 'C' => 0, 'G' => 0, 'T' => 0}) do |nucleotide, counts|
    unless counts.key?(nucleotide)
      raise InvalidNucleotideError
    end
    counts[nucleotide] += 1
  end.tap { |hash| hash.define_singleton_method(:histogram) { self } }

}

def Nucleotide.from_dna(dna_strand) = self.(dna_strand)

class InvalidNucleotideError < ArgumentError
  def initialize(message = 'Invalid nucleotide (expected %s)' % 'A, C, G, or T')
    super
  end
end
