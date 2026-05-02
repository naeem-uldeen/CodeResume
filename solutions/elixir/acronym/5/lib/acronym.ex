defmodule Acronym do

  defp words(phrase) do
    String.split(phrase,[" ", "_", "-"])
  end

  def abbreviate(phrase) when is_binary(phrase) do
    phrase
    |> words()
    |> Enum.map_join(&String.first/1)
    |> String.upcase()
  end

end
