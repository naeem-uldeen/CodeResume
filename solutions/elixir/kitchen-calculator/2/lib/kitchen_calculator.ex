defmodule KitchenCalculator do

  @us_to_ml %{
    milliliter: 1,
    cup: 240,
    fluid_ounce: 30,
    teaspoon: 5,
    tablespoon: 15
  }

  def get_volume({_, volume}), do: volume

  def to_milliliter({unit, volume}),
    do: {:milliliter, volume * @us_to_ml[unit]}

  def from_milliliter({_, volume}, unit),
    do: {unit, volume / @us_to_ml[unit]}

  def convert(volume_pair, unit) do
    volume_pair
    |> to_milliliter()
    |> from_milliliter(unit)
  end
  
end
