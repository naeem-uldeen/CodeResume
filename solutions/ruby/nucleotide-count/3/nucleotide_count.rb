class InvalidNucleotideError < ArgumentError
  def initialize(message = 'Invalid nucleotide (expected %s)' % 'A, C, G, or T')
    super
  end
end

Nucleotide = ->(dna_strand) {

  NUCLEOTIDE_HASH = {'A' => 0, 'C' => 0, 'G' => 0, 'T' => 0}

  dna_strand
    .chars
    .each_with_object NUCLEOTIDE_HASH do |nucleotide, counts|
    not counts.key?(nucleotide) and raise InvalidNucleotideError

    counts[nucleotide] += 1
  end.tap { |hash| hash.define_singleton_method(:histogram) { self } }

}

def Nucleotide.from_dna(dna_strand) = self.(dna_strand)
