class Complement

  DNA = 'GCTA'
  RNA = 'CGAU'
  private_constant :DNA, :RNA

  def self.of_dna sequence
    new(sequence).rna_translation
  end

  private

  attr_writer :sequence

  def initialize sequence
    self.sequence = sequence
  end

  public

  attr_reader :sequence

  def rna_translation
    sequence.tr DNA, RNA
  end

end
