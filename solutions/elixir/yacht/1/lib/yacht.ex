defmodule Yacht do

  @type category ::
  :ones | :twos | :threes | :fours | :fives | :sixes
  | :full_house | :four_of_a_kind
  | :little_straight | :big_straight
  | :choice | :yacht

  def score(:yacht, [d, d, d, d, d]), do: 50
  def score(:yacht, _), do: 0

  def score(:ones,   dice), do: Enum.count(dice, &(&1 == 1)) * 1
  def score(:twos,   dice), do: Enum.count(dice, &(&1 == 2)) * 2
  def score(:threes, dice), do: Enum.count(dice, &(&1 == 3)) * 3
  def score(:fours,  dice), do: Enum.count(dice, &(&1 == 4)) * 4
  def score(:fives,  dice), do: Enum.count(dice, &(&1 == 5)) * 5
  def score(:sixes,  dice), do: Enum.count(dice, &(&1 == 6)) * 6

  def score(:full_house, dice) do
    case dice
    |> Enum.frequencies()
    |> Map.values()
    |> Enum.sort() do
      [2, 3] -> Enum.sum(dice)
      _      -> 0
    end
  end

  def score(:four_of_a_kind, dice) do
    case dice
    |> Enum.frequencies()
    |> Enum.find(fn {_, count} -> count >= 4 end) do
      {val, _} -> val * 4
      nil      -> 0
    end
  end

  def score(:little_straight, dice) do
    case Enum.sort(dice) do
      [1, 2, 3, 4, 5] -> 30
      _               -> 0
    end
  end

  def score(:big_straight, dice) do
    case Enum.sort(dice) do
      [2, 3, 4, 5, 6] -> 30
      _               -> 0
    end
  end

  def score(:choice, dice), do: Enum.sum(dice)

end
