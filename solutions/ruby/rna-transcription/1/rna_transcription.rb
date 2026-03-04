module Complement

  def self.of_dna(strand)
    strand.tr('GCTA', 'CGAU')
  end

end
