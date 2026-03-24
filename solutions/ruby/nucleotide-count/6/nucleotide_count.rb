Nucleotide = ->(dna_strand) {
  base_counts = {'A' => 0, 'C' => 0, 'G' => 0, 'T' => 0}
  dna_strand
    .each_char do |nucleotide|
      base_counts.key?(nucleotide) or raise InvalidNucleotideError
      base_counts[nucleotide] += 1
    end.then { base_counts.define_singleton_method(:histogram) { self }; base_counts }
}

def Nucleotide.from_dna(dna_strand) = call dna_strand

class InvalidNucleotideError < ArgumentError
  def initialize(message = 'Invalid nucleotide (expected %s)' % 'A, C, G, or T')
    super
  end
end
