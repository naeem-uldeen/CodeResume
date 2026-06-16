defmodule Allergies do
  import Bitwise

  @flags_and_allergens [
    {1,   "eggs"},
    {2,   "peanuts"},
    {4,   "shellfish"},
    {8,   "strawberries"},
    {16,  "tomatoes"},
    {32,  "chocolate"},
    {64,  "pollen"},
    {128, "cats"}
  ]

  @spec list(non_neg_integer) :: [String.t()]
  def list(foods) do
    for {flag, allergen} <- @flags_and_allergens, band(foods, flag) != 0, do: allergen
  end

  @spec allergic_to?(non_neg_integer, String.t()) :: boolean
  for {flag, allergen} <- @flags_and_allergens do
    def allergic_to?(foods, unquote(allergen)), do: band(foods, unquote(flag)) != 0
  end
  
end
