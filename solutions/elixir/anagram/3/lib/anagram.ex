defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates),
    do:
      with(
        low_base_letters = String.to_charlist(String.downcase(base)),
        size = length(low_base_letters),
        do: Enum.filter(candidates, &anagram?(&1, low_base_letters, size))
      )

  defp anagram?(candidate, low_base_letters, size),
    do:
      with(
        low_candidate_letters = String.to_charlist(String.downcase(candidate)),
        do:
          low_candidate_letters != low_base_letters and
            length(low_candidate_letters) == size and
            # --/2 computes the multiset difference: if low_candidate's letters
            # are a subset of base's (same bag of characters), the remainder is
            # empty. Combined with equal length, the two bags are identical —
            # exactly the definition of an anagram.
            (low_base_letters -- low_candidate_letters) == []
      )
end
