defmodule KitchenCalculator do

  @us_to_ml %{
    milliliter: 1,
    cup: 240,
    fluid_ounce: 30,
    teaspoon: 5,
    tablespoon: 15
  }

  def get_volume(volume_pair) do
    {_, numeric_component} = volume_pair
    numeric_component
  end

  def to_milliliter(volume_pair) do
    {us_measure, _} = volume_pair
    numeric_component = get_volume(volume_pair)
    # Multiply the numeric value by the conversion factor then,
    # wrap the result in a {:milliliter, ...} tuple
    {:milliliter, numeric_component * @us_to_ml[us_measure]}
  end

  def from_milliliter(volume_pair, unit) do
    numeric_component = get_volume(volume_pair)
     # Divide the numeric value by the conversion factor then,
     # wrap the result in a {unit, ...} tuple
    {unit, numeric_component / @us_to_ml[unit]}
  end

  def convert(volume_pair, unit) do
    volume_pair
    |> to_milliliter()
    |> from_milliliter(unit)
  end

end
