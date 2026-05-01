defmodule Acronym do

  @delimiters [" ", "_", "-"]

  defp custom_split(str) when is_binary(str) do
    String.split(str, @delimiters)
  end

  def abbreviate(phrase) do
    phrase
    |> custom_split()
    |> Enum.map_join(&String.first/1)
    |> String.upcase()
  end

end
