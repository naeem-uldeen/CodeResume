defmodule WordCount do

  @spec count(String.t()) :: %{optional(String.t()) => pos_integer()}
  def count(sentence), do: count_words(sentence)

  defp count_words(sentence, current \\ <<>>, counts \\ %{})

  # Most frequent matches first — hit immediately on every letter/digit
  defp count_words(<<char, rest::binary>>, current, counts) when char in ?a..?z,
    do: count_words(rest, <<current::binary, char>>, counts)

  defp count_words(<<char, rest::binary>>, current, counts) when char in ?A..?Z,
    do: count_words(rest, <<current::binary, char + 32>>, counts)

  defp count_words(<<char, rest::binary>>, current, counts) when char in ?0..?9,
    do: count_words(rest, <<current::binary, char>>, counts)

  # Apostrophe: skip if no word started yet, otherwise accumulate
  defp count_words(<<?', rest::binary>>, <<>>, counts),
    do: count_words(rest, <<>>, counts)

  defp count_words(<<?', rest::binary>>, current, counts),
    do: count_words(rest, <<current::binary, ?'>>, counts)

  # Word boundary: discard separator, flush word if one is in progress
  defp count_words(<<_, rest::binary>>, <<>>, counts),
    do: count_words(rest, <<>>, counts)

  defp count_words(<<_, rest::binary>>, current, counts),
    do: count_words(rest, <<>>, count_word(counts, current))

  # Base cases last — only reached once, no point jumping over them every recursion
  defp count_words(<<>>, <<>>, counts), do: counts
  defp count_words(<<>>, current, counts), do: count_word(counts, current)

  # Empty-word guard removed: callers above already ensure current is non-empty
  # before calling here, so the clause was dead code
  defp count_word(counts, word),
    do: Map.update(counts, String.trim_trailing(word, "'"), 1, &(&1 + 1))

end
