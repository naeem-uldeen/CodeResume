defmodule WordCount do

  def count(phrase),
    do: Enum.frequencies(collect_words(String.downcase(phrase), [], []))

  defp collect_words("", [], words),      do: words
  defp collect_words("", current, words), do: commit_word(current, words)

  defp collect_words(phrase, current, words) do
    case String.next_grapheme(phrase) do
      {"'",  rest} when current == [] -> collect_words(rest, [], words)
      {"'",  rest} -> collect_words(rest, ["'" | current], words)
      {char, rest} when
        char >= "a" and char <= "z" -> collect_words(rest, [char | current], words)
      {char, rest} when
        char >= "0" and char <= "9" -> collect_words(rest, [char | current], words)
      {_separator, rest} -> collect_words(rest, [], commit_word(current, words))
    end
  end

  defp commit_word([],           words), do: words
  defp commit_word(["'" | rest], words), do: commit_word(rest, words)
  defp commit_word(chars,        words), do: [Enum.join(Enum.reverse(chars)) | words]

end
