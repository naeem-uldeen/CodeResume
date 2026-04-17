defmodule Yacht do

  @type category ::
          :ones | :twos | :threes | :fours | :fives | :sixes
          | :full_house | :four_of_a_kind
          | :little_straight | :big_straight
          | :choice | :yacht

  def score(:ones, dice),            do: sum(1, dice)
  def score(:twos, dice),            do: sum(2, dice)
  def score(:threes, dice),          do: sum(3, dice)
  def score(:fours, dice),           do: sum(4, dice)
  def score(:fives, dice),           do: sum(5, dice)
  def score(:sixes, dice),           do: sum(6, dice)
  def score(:full_house, dice),      do: expected_frequencies([2, 3], dice)
  def score(:four_of_a_kind, dice),  do: four_of_a_kind(dice)
  def score(:little_straight, dice), do: five_in_a_row(1, 30, dice)
  def score(:big_straight, dice),    do: five_in_a_row(2, 30, dice)
  def score(:choice, dice),          do: Enum.sum(dice)
  def score(:yacht, [d, d, d, d, d]),do: 50
  def score(_, _),                   do: 0

  defp sum(face, dice) do
    dice
    |> Enum.filter(&(&1 == face))
    |> Enum.sum()
  end

  defp expected_frequencies(expected_counts, dice) do
    actual_counts =
      dice
      |> Enum.frequencies()
      |> Map.values()
      |> Enum.sort()

    if actual_counts == expected_counts,
      do: Enum.sum(dice),
      else: 0
  end

  defp four_of_a_kind(dice) do
    case Enum.frequencies(dice)
      |> Enum.find(&(elem(&1, 1) >= 4)) do
      {val, _} -> val * 4
      nil      -> 0
    end
  end

  defp five_in_a_row(first, points, dice) do
    if Enum.sort(dice) == Enum.to_list(first..(first + 4)),
      do: points,
      else: 0
  end

end
