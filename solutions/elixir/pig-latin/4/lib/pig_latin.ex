defmodule PigLatin do

  @vowels ~c"aeiou"
  @consonants Enum.to_list(?a..?z) -- @vowels

  def translate(phrase) do
    phrase
    |> String.split(" ")
    |> Enum.map_join(" ", &pig_latin/1)
  end

  defp pig_latin(word) do
    {prefix, rest} = split_prefix(word)
    rest <> prefix <> "ay"
  end

  # Empty prefix: the whole word stays as-is, "ay" is appended
  defp split_prefix(<<c, _::binary>> = word) when c in @vowels, do: {"", word}
  defp split_prefix(<<?x, ?r, _::binary>> = word), do: {"", word}
  defp split_prefix(<<?y, c,  _::binary>> = word) when c in @consonants, do: {"", word}

  # Known clusters moved to prefix
  defp split_prefix(<<?t, ?h, ?r, rest::binary>>), do: {"thr", rest}
  defp split_prefix(<<?s, ?c, ?h, rest::binary>>), do: {"sch", rest}
  defp split_prefix(<<?s, ?q, ?u, rest::binary>>), do: {"squ", rest}
  defp split_prefix(<<?c, ?h,     rest::binary>>), do: {"ch",  rest}
  defp split_prefix(<<?t, ?h,     rest::binary>>), do: {"th",  rest}
  defp split_prefix(<<?q, ?u,     rest::binary>>), do: {"qu",  rest}

  # Consume consonants up to (but not including) a medial y or vowel
  defp split_prefix(word) do
    {consonants, _} =
      word
      |> String.to_charlist()
      |> Enum.split_while(&(&1 in @consonants and &1 != ?y))

    String.split_at(word, max(length(consonants), 1))
  end

end
