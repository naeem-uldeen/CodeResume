defmodule KitchenCalculator do

  @ml_per_cup   240
  @ml_per_floz   30
  @ml_per_tsp     5
  @ml_per_tbsp   15

  def get_volume({_unit, volume}), do: volume

  def to_milliliter({:milliliter, ml}),
    do: {:milliliter, ml}
  def to_milliliter({:cup, cups}),
    do: {:milliliter, cups * @ml_per_cup}
  def to_milliliter({:fluid_ounce, floz}),
    do: {:milliliter, floz * @ml_per_floz}
  def to_milliliter({:teaspoon, tsp}),
    do: {:milliliter, tsp * @ml_per_tsp}
  def to_milliliter({:tablespoon, tbsp}),
    do: {:milliliter, tbsp * @ml_per_tbsp}

  def from_milliliter({:milliliter, ml}, :milliliter),
    do: {:milliliter, ml}
  def from_milliliter({:milliliter, ml}, :cup),
    do: {:cup, ml / @ml_per_cup}
  def from_milliliter({:milliliter, ml}, :fluid_ounce),
    do: {:fluid_ounce, ml / @ml_per_floz}
  def from_milliliter({:milliliter, ml}, :teaspoon),
    do: {:teaspoon, ml / @ml_per_tsp}
  def from_milliliter({:milliliter, ml}, :tablespoon),
    do: {:tablespoon, ml / @ml_per_tbsp}

  def convert(volume_pair, unit) do
    volume_pair
    |> to_milliliter()
    |> from_milliliter(unit)
  end

end