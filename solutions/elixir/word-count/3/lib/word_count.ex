defmodule WordCount do

  @spec count(String.t()) :: %{optional(String.t()) => pos_integer()}
  def count(sentence), do: count_words(sentence)

  defp count_words(sentence, current \\ <<>>, counts \\ %{})

  defp count_words(<<>>, <<>>, counts), do: counts

  defp count_words(<<>>, current, counts), do: count_word(counts, current)

  defp count_words(<<?', rest::binary>>, <<>>, counts),
    do: count_words(rest, <<>>, counts)

  defp count_words(<<?', rest::binary>>, current, counts),
    do: count_words(rest, <<current::binary, ?'>>, counts)

  defp count_words(<<char, rest::binary>>, current, counts) when char in ?a..?z,
    do: count_words(rest, <<current::binary, char>>, counts)

  defp count_words(<<char, rest::binary>>, current, counts) when char in ?A..?Z,
    do: count_words(rest, <<current::binary, char + 32>>, counts)

  defp count_words(<<char, rest::binary>>, current, counts) when char in ?0..?9,
    do: count_words(rest, <<current::binary, char>>, counts)

  defp count_words(<<_, rest::binary>>, <<>>, counts),
    do: count_words(rest, <<>>, counts)

  defp count_words(<<_, rest::binary>>, current, counts),
    do: count_words(rest, <<>>, count_word(counts, current))

  defp count_word(counts, <<>>), do: counts

  defp count_word(counts, word),
    do: Map.update(counts, String.trim_trailing(word, "'"), 1, &(&1 + 1))

end
