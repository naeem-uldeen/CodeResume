defmodule Anagram do

  def match(base, candidates),
    do: candidates|> Enum.filter(&anagram?(&1, base))

  defp anagram?(candidate, base),
    do: anagram?(String.downcase(candidate),
                 String.downcase(base),
                 candidate, base)
  defp anagram?(same, same, _candidate, _base), do: false
  defp anagram?(_low_candidate, _low_base, candidate, base),
    do: normalize(candidate) == normalize(base)

  defp normalize(word) do
    word
    |> String.downcase()
    |> String.graphemes()
    |> Enum.sort()
  end

end
