defmodule Yacht do

  @type category ::
          :ones | :twos | :threes | :fours | :fives | :sixes
          | :full_house | :four_of_a_kind
          | :little_straight | :big_straight
          | :choice | :yacht

  def score(:ones, dice),   do: count(1, dice)
  def score(:twos, dice),   do: count(2, dice)
  def score(:threes, dice), do: count(3, dice)
  def score(:fours, dice),  do: count(4, dice)
  def score(:fives, dice),  do: count(5, dice)
  def score(:sixes, dice),  do: count(6, dice)

  def score(:full_house, dice) do
    dice
    |> Enum.frequencies()
    |> Map.values()
    |> Enum.sort()
    |> full_house_score(dice)
  end

  def score(:four_of_a_kind, dice) do
    dice
    |> Enum.frequencies()
    |> Enum.find(&(elem(&1, 1) >= 4))
    |> four_of_a_kind_score()
  end

  def score(:little_straight, dice),
    do: straight_score(Enum.sort(dice), [1, 2, 3, 4, 5])
  def score(:big_straight, dice),
    do: straight_score(Enum.sort(dice), [2, 3, 4, 5, 6])

  def score(:choice, dice), do: Enum.sum(dice)
  def score(:yacht, [d, d, d, d, d]), do: 50
  def score(:yacht, _), do: 0
  def score(_, _), do: 0

  defp count(face, dice),
    do: dice |> Enum.filter(&(&1 == face)) |> Enum.sum()

  defp full_house_score([2, 3], dice), do: Enum.sum(dice)
  defp full_house_score(_, _), do: 0

  defp four_of_a_kind_score({val, _}), do: val * 4
  defp four_of_a_kind_score(nil), do: 0

  defp straight_score(same, same), do: 30
  defp straight_score(_, _), do: 0
  
end
