defmodule KitchenCalculator do

  @milliliters_per_cup         240
  @milliliters_per_fluid_ounce  30
  @milliliters_per_teaspoon      5
  @milliliters_per_tablespoon   15

  def get_volume({_unit, volume}), do: volume

  def to_milliliter({:milliliter, volume}),
    do: {:milliliter, volume}
  def to_milliliter({:cup, cups}),
    do: {:milliliter, cups * @milliliters_per_cup}
  def to_milliliter({:fluid_ounce, floz}),
    do: {:milliliter, floz * @milliliters_per_fluid_ounce}
  def to_milliliter({:teaspoon, tsp}),
    do: {:milliliter, tsp * @milliliters_per_teaspoon}
  def to_milliliter({:tablespoon, tbsp}),
    do: {:milliliter, tbsp * @milliliters_per_tablespoon}

  def from_milliliter({:milliliter, volume}, :milliliter),
    do: {:milliliter, volume}
  def from_milliliter({:milliliter, volume}, :cup),
    do: {:cup, volume / @milliliters_per_cup}
  def from_milliliter({:milliliter, volume}, :fluid_ounce),
    do: {:fluid_ounce, volume / @milliliters_per_fluid_ounce}
  def from_milliliter({:milliliter, volume}, :teaspoon),
    do: {:teaspoon, volume / @milliliters_per_teaspoon}
  def from_milliliter({:milliliter, volume}, :tablespoon),
    do: {:tablespoon, volume / @milliliters_per_tablespoon}

  def convert(volume_pair, unit) do
    volume_pair
    |> to_milliliter()
    |> from_milliliter(unit)
  end
  
end
