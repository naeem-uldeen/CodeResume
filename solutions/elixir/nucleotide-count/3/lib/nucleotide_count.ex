defmodule NucleotideCount do

  @nucleotides [?A, ?C, ?G, ?T]

  def histogram(strand), do: histogram(strand, 0, 0, 0, 0)

  defp histogram([], a, c, g, t),
    do: %{?A => a, ?C => c, ?G => g, ?T => t}

  defp histogram([?A | rest], a, c, g, t),
    do: histogram(rest, a + 1, c, g, t)

  defp histogram([?C | rest], a, c, g, t),
    do: histogram(rest, a, c + 1, g, t)

  defp histogram([?G | rest], a, c, g, t),
    do: histogram(rest, a, c, g + 1, t)

  defp histogram([?T | rest], a, c, g, t),
    do: histogram(rest, a, c, g, t + 1)

  def count(strand, nucleotide) when nucleotide in @nucleotides,
    do: Enum.count(strand, &match?(^nucleotide, &1))

end
