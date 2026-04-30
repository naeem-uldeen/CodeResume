defmodule Raindrops do

  defp number_to_drop do
    [
      &if(rem(&1, 3) == 0, do: "Pling"),
      &if(rem(&1, 5) == 0, do: "Plang"),
      &if(rem(&1, 7) == 0, do: "Plong")
    ]
  end

  def convert(number) do
    drops = for splash_pattern <- number_to_drop(),
            drop = splash_pattern.(number),
            drop != nil,  do: drop

    case drops do
      [] -> to_string(number)
      _  -> Enum.join(drops)
    end
  end

end
