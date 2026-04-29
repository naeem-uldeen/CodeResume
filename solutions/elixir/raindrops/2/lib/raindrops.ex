defmodule Raindrops do

  defp drop_patterns do
    [
      &if(rem(&1, 3) == 0, do: "Pling"),
      &if(rem(&1, 5) == 0, do: "Plang"),
      &if(rem(&1, 7) == 0, do: "Plong")
    ]
  end

  def convert(number) do
    drops = drop_patterns()
      |> Enum.map(& &1.(number)) 
      |> Enum.join()
      
    if drops == "", do: Integer.to_string(number), else: drops
  end
  
end
