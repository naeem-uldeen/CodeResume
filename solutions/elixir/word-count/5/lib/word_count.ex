defmodule WordCount do

  def count(sentence), do: count_words(sentence)
  defp count_words(sentence, current \\ <<>>, counts \\ %{})

  defp count_words(<<char, rest::binary>>, current, counts) when char in ?a..?z,
    do: count_words(rest, <<current::binary, char>>, counts)
  defp count_words(<<char, rest::binary>>, current, counts) when char in ?A..?Z,
    do: count_words(rest, <<current::binary, char + 32>>, counts)
  defp count_words(<<char, rest::binary>>, current, counts) when char in ?0..?9,
    do: count_words(rest, <<current::binary, char>>, counts)

  # Apostrophe at end of input — drop it
  # Apostrophe before a space — drop it, re-inject it so word boundary normal
  # Apostrophe with no word in progress — drop it
  # Apostrophe mid-word — keep it
  defp count_words(<<?\'>>, current, counts),
    do: count_words(<<>>, current, counts)
  defp count_words(<<?\', ?\s, rest::binary>>, current, counts),
    do: count_words(<<?\s, rest::binary>>, current, counts)
  defp count_words(<<?\', rest::binary>>, <<>>, counts),
    do: count_words(rest, <<>>, counts)
  defp count_words(<<?\', rest::binary>>, current, counts),
    do: count_words(rest, <<current::binary, ?\'>>, counts)

  defp count_words(<<_, rest::binary>>, <<>>, counts),
    do: count_words(rest, <<>>, counts)
  defp count_words(<<_, rest::binary>>, current, counts),
    do: count_words(rest, <<>>, count_word(counts, current))

  defp count_words(<<>>, <<>>, counts), do: counts
  defp count_words(<<>>, current, counts), do: count_word(counts, current)

  defp count_word(counts, word),
    do: Map.update(counts, word, 1, &(&1 + 1))

end
