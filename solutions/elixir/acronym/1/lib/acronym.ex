defmodule Acronym do

  # Regex splits on whitespace,
  # dashes and underscores
  @delimiters ~r/[\s_-]+/

  def custom_split(str) when is_binary(str) do
    String.split(str, @delimiters)
  end

  def abbreviate(phrase) do
    phrase
    |> custom_split()
    |> Enum.map(&String.first(&1))
    |> Enum.join()
    |> String.upcase()
  end

end
