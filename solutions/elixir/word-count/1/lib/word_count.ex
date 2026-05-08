defmodule WordCount do

  def count(sentence) do
    sentence
    |> String.downcase()
    |> String.graphemes()
    |> Enum.map(fn character ->
      cond do
        alphanumeric?(character) or
        character == "'" -> character
        true -> " "
      end
    end)
    |> Enum.join()
    |> String.split()
    |> Enum.map(&String.trim(&1, "'"))
    |> Enum.reject(&(&1 == ""))
    |> Enum.frequencies()
  end

  defp alphanumeric?(c) do
    (c >= "a" and c <= "z") or (c >= "0" and c <= "9")
  end

end
