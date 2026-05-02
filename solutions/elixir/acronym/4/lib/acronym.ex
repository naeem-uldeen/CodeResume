defmodule Acronym do

  @word_separators [" ", "_", "-"]

  defp words(phrase) do
    String.split(phrase, @word_separators)
  end

  def abbreviate(phrase) when is_binary(phrase) do
    phrase
    |> words()
    |> Enum.map_join(&String.first/1)
    |> String.upcase()
  end

end
