defmodule Pangram do

  def pangram?(sentence) do
    letters =
      sentence
      |> String.downcase()
      |> String.to_charlist()
      |> Enum.filter(&(&1 in ?a..?z))
      |> MapSet.new()

    MapSet.subset?(MapSet.new(?a..?z), letters)
  end
  
end
