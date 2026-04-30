defmodule Raindrops do

  def convert(number) do
    drop = [
      &if(rem(&1, 3) == 0, do: "Pling", else: ""),
      &if(rem(&1, 5) == 0, do: "Plang", else: ""),
      &if(rem(&1, 7) == 0, do: "Plong", else: "")
    ]
    |> Enum.map(& &1.(number))
    |> Enum.join()

    if drop == "", do: to_string(number), else: drop
  end

end
