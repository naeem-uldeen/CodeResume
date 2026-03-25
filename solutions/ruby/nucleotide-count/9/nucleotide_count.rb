Nucleotide = ->(dna_strand) {
  base_counts = {'A' => 0, 'C' => 0, 'G' => 0, 'T' => 0}
  dna_strand.each_char { |nucleotide|
    raise InvalidNucleotideError unless
      base_counts.key?(nucleotide)
  }
  base_counts
    .merge!(dna_strand.each_char.tally)
    .define_singleton_method(:histogram){ base_counts }

  base_counts
}

def Nucleotide.from_dna(dna_strand) = call dna_strand

class InvalidNucleotideError < ArgumentError
  def initialize(message =
      'Invalid nucleotide (expected %s)' %
      'A, C, G, or T')
    super
  end
end
