defmodule Allergies do

  @allergens %{
    1 => "eggs",
    2 => "peanuts",
    4 => "shellfish",
    8 => "strawberries",
    16 => "tomatoes",
    32 => "chocolate",
    64 => "pollen",
    128 => "cats"
  }
  @food_to_bit @allergens |> Enum.into(%{}, fn {bit, food} -> {food, bit} end)


  def list(score) do
    for {bit, food} <- @allergens, Bitwise.band(bit, score) != 0, do: food
  end

  def allergic_to?(score, food) do
    case @food_to_bit[food] do
      nil -> false
      bit -> Bitwise.band(score, bit) != 0
    end
  end
  
end
