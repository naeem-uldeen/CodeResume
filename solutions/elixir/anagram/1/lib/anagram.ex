defmodule Anagram do

  def match(base, candidates) do
    candidates
    |> Enum.filter(&is_anagram?(&1, base))
  end

  defp is_anagram?(candidate, base) do
    normalized(candidate) == normalized(base) and
    String.downcase(candidate) != String.downcase(base)
  end

  defp normalized(word) do
    word
    |> String.downcase()
    |> String.graphemes()
    |> Enum.sort()
  end
  
end
