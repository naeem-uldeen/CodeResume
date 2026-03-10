class Complement

  DNA = 'GCTA'
  RNA = 'CGAU'
  private_constant :DNA, :RNA

  def self.of_dna sequence
    new(sequence).rna_translation
  end

  private

  attr_writer :dna_sequence

  def initialize dna_sequence
    self.dna_sequence = dna_sequence
  end

  public

  attr_reader :dna_sequence

  def rna_translation
    sequence.tr DNA, RNA
  end

end
