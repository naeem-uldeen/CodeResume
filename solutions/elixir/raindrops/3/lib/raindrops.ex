defmodule Raindrops do

  @drop_patterns [
    {3, "Pling"},
    {5, "Plang"},
    {7, "Plong"}
  ]

  defp drop_patterns do
    Enum.map(@drop_patterns, fn {divisor, sound} ->
      &if(rem(&1, divisor) == 0, do: sound)
    end)
  end

  def convert(number) do
    drops = Enum.map_join(drop_patterns(), & &1.(number))
    if drops == "", do: Integer.to_string(number), else: drops
  end
  
end
