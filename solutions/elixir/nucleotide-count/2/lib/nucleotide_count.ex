defmodule NucleotideCount do

  @nucleotides [?A, ?C, ?G, ?T]

  @spec histogram(String.t()) :: map()
  def histogram(strand),
    do: with frequencies <- Enum.frequencies(strand),
    do: Enum.into(@nucleotides, %{}, &{&1, Map.get(frequencies, &1, 0)})

  @spec count(String.t(), char()) :: non_neg_integer()
  def count(strand, nucleotide) when
    nucleotide in @nucleotides,
    do: Enum.count(strand, &(&1 == nucleotide))

end
