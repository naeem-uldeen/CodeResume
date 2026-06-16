defmodule Allergies do
  import Bitwise

  @allergens ~w[
    eggs
    peanuts
    shellfish
    strawberries
    tomatoes
    chocolate
    pollen
    cats
  ]

  @spec list(non_neg_integer) :: [String.t()]
  def list(foods) do
    @allergens
    |> Enum.with_index()
    |> Enum.filter(&((foods &&& 1 <<< elem(&1, 1)) != 0))
    |> Enum.map(&elem(&1, 0))
  end

  @spec allergic_to?(non_neg_integer, String.t()) :: boolean
  def allergic_to?(foods, food), do: food in list(foods)

end
