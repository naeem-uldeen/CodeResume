defmodule Pangram do

  def pangram?(phrase) do
    phrase
    |> String.downcase()
    |> String.to_charlist()
    |> Enum.filter(&(&1 in ?a..?z))
    |> MapSet.new()
    |> MapSet.size() == 26
  end
  
end
