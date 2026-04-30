defmodule RnaTranscription do
  @moduledoc """
  Transcribes DNA sequences into RNA sequences.
  Each nucleotide is mapped as follows:
    - A -> U
    - C -> G
    - G -> C
    - T -> A
  The implementation uses private tail-recursive helper `rna/2` with a
  default-value function head to hide the accumulator from the public API.
  """
  @typedoc "A list of DNA nucleotide character codes"
  @type dna :: charlist()

  @typedoc "A list of RNA nucleotide character codes"
  @type rna :: charlist()

  @doc """
  Transcribes a DNA charlist into its RNA complement.
  ## Examples

      iex> RnaTranscription.to_rna('ACGT')
      'UGCA'

      iex> RnaTranscription.to_rna('TTAG')
      'AAUC'
  """
  @spec to_rna(dna()) :: rna()
  def to_rna(dna), do: rna(dna)

  # Function head declaring the default accumulator value.
  # Expands to: defp rna(dna), do: rna(dna, [])
  # This keeps the accumulator as a private implementation detail —
  # the caller (to_rna/1) only needs to pass the DNA sequence.
  @spec rna(dna(), rna()) :: rna()
  defp rna(dna, rna \\ [])

  defp rna([?A | dna], rna), do: rna(dna, [?U | rna])  # A -> U
  defp rna([?C | dna], rna), do: rna(dna, [?G | rna])  # C -> G
  defp rna([?G | dna], rna), do: rna(dna, [?C | rna])  # G -> C
  defp rna([?T | dna], rna), do: rna(dna, [?A | rna])  # T -> A

  # Base case: reverse the accumulator built up by prepending,
  # restoring the correct left-to-right order.
  defp rna([], rna), do: Enum.reverse(rna)

end
