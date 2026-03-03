VALID_NUCLEOTIDES = {'A' => 0, 'C' => 0, 'G' => 0, 'T' => 0}

Nucleotide = ->(dna_strand) {
  nucleotide_counts = VALID_NUCLEOTIDES.dup

  dna_strand.each_char do |nucleotide|
    unless VALID_NUCLEOTIDES.key?(nucleotide)
      raise INVAILD_NUCLEOTIDE_ERROR
    end
    nucleotide_counts[nucleotide] += 1
  end

  nucleotide_counts.tap do |counts_hash|
    def counts_hash.histogram
      self
    end
  end
}

def Nucleotide.from_dna(dna_strand)
  self.(dna_strand)
end

class INVAILD_NUCLEOTIDE_ERROR < ArgumentError
  def initialize(message = 'Invalid nucleotide (expected %s)' % 'A, C, G, or T')
    super
  end
end
