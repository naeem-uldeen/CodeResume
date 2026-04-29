defmodule RnaTranscription do

  @dna_to_rna %{ ?G =>?C, ?C => ?G, ?T => ?A, ?A => ?U }

  def to_rna(dna) do
    rna = &(@dna_to_rna[&1])
    Enum.map(dna, rna)
  end

end
