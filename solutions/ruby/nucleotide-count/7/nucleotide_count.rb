Nucleotide = ->(dna_strand) {
  base_counts = {'A' => 0, 'C' => 0, 'G' => 0, 'T' => 0}
  dna_strand.each_char { |nucleotide|
    base_counts.key?(nucleotide) or raise InvalidNucleotideError
  }
  base_counts.merge!(dna_strand.each_char.tally)
  base_counts.tap { |counts| counts.define_singleton_method(:histogram) { self } }
}

def Nucleotide.from_dna(dna_strand) = call dna_strand

class InvalidNucleotideError < ArgumentError
  def initialize(message = 'Invalid nucleotide (expected %s)' % 'A, C, G, or T')
    super
  end
end
