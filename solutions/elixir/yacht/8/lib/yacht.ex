defmodule Yacht do

  @type face :: 1..6
  @type points :: 0..50
  @type category ::
    :ones | :twos | :threes | :fours | :fives | :sixes
  | :full_house | :four_of_a_kind
  | :little_straight | :big_straight
  | :choice | :yacht

  @categories [
    :ones, :twos, :threes, :fours, :fives, :sixes,
    :full_house, :four_of_a_kind,
    :little_straight, :big_straight,
    :choice, :yacht
  ]

  @spec score(category(), [face()]) :: points()
  def score(category, dice = [f, _, _, _, _])
      when category in @categories and
           f in 1..6,
      do: score_sorted(category, Enum.sort(dice))

  defp score_sorted(:ones,   dice), do: sum_of_face(1, dice)
  defp score_sorted(:twos,   dice), do: sum_of_face(2, dice)
  defp score_sorted(:threes, dice), do: sum_of_face(3, dice)
  defp score_sorted(:fours,  dice), do: sum_of_face(4, dice)
  defp score_sorted(:fives,  dice), do: sum_of_face(5, dice)
  defp score_sorted(:sixes,  dice), do: sum_of_face(6, dice)
  defp score_sorted(:full_house,    [d1, d1, d1, d2, d2]) when
    d1 != d2, do: 3 * d1 + 2 * d2
  defp score_sorted(:full_house,    [d1, d1, d2, d2, d2])
    when d1 != d2, do: 2 * d1 + 3 * d2
  defp score_sorted(:four_of_a_kind,[d,  d,  d,  d,  _]),    do: 4 * d
  defp score_sorted(:four_of_a_kind,[_,  d,  d,  d,  d]),    do: 4 * d
  defp score_sorted(:little_straight,[1, 2,  3,  4,  5]),    do: 30
  defp score_sorted(:big_straight,   [2, 3,  4,  5,  6]),    do: 30
  defp score_sorted(:yacht,          [d, d,  d,  d,  d]),    do: 50
  defp score_sorted(:choice, dice),                          do: Enum.sum(dice)
  defp score_sorted(_category, _dice_not_matching_category), do: 0

  defp sum_of_face(face, dice), do: face * Enum.count(dice, &(&1 == face))

end
