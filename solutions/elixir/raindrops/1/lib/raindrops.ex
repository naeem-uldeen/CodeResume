defmodule Raindrops do

  def convert(number) do
    raindrops = [
       &if rem(&1, 3) == 0 do "Pling" else "" end,
       &if rem(&1, 5) == 0 do "Plang" else "" end,
       &if rem(&1 ,7) == 0 do "Plong" else "" end
    ]
    result = raindrops |> Enum.map_join("", & &1.(number))
    if result === "" do Integer.to_string(number) else result end
  end
  
end
