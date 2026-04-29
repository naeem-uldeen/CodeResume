defmodule RnaTranscription do

  # Main entry point. Takes a DNA list and starts the recursive
  # translation with an empty list as an accumulator.

  def to_rna(dna), do: rna(dna, [])

  # --- Private recursive steps ---
  # Each clause matches the first character (head) of the DNA list,
  # prepends the RNA equivalent to the results, and recurses on the rest.

  defp rna([?A | dna], rna),
    do: rna(dna, [?U | rna]) # A -> U
  defp rna([?C | dna], rna),
    do: rna(dna, [?G | rna]) # C -> G
  defp rna([?G | dna], rna),
    do: rna(dna, [?C | rna]) # G -> C
  defp rna([?T | dna], rna),
    do: rna(dna, [?A | rna]) # T -> A

  # Base case: When the DNA list is empty, reverse the accumulator
  # (since we prepended items for efficiency) and return the result.

  defp rna([], rna), do: Enum.reverse(rna)

end
