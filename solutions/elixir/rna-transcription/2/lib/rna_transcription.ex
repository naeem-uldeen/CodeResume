defmodule RnaTranscription do

  def to_rna(dna), do: Enum.map(dna, &rna/1)

  defp rna(?G), do: ?C
  defp rna(?C), do: ?G
  defp rna(?T), do: ?A
  defp rna(?A), do: ?U

end
