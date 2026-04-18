defmodule Yacht do

  @categories [:full_house, :four_of_a_kind, :little_straight, :big_straight, :yacht]

  @type category ::
          :ones | :twos | :threes | :fours | :fives | :sixes
          | :full_house | :four_of_a_kind
          | :little_straight | :big_straight
          | :choice | :yacht

  def score(:ones, dice),   do: count_face(1, dice)
  def score(:twos, dice),   do: count_face(2, dice)
  def score(:threes, dice), do: count_face(3, dice)
  def score(:fours, dice),  do: count_face(4, dice)
  def score(:fives, dice),  do: count_face(5, dice)
  def score(:sixes, dice),  do: count_face(6, dice)

  def score(category, dice) when
    category in @categories do
      case {category, Enum.sort(dice)} do
        {:full_house, [d1, d1, d1, d2, d2]} when d1 != d2 -> 3 * d1 + 2 * d2
        {:full_house, [d1, d1, d2, d2, d2]} when d1 != d2 -> 2 * d1 + 3 * d2
        {:four_of_a_kind, [d, d, d, d, _]} -> 4 * d
        {:four_of_a_kind, [_, d, d, d, d]} -> 4 * d
        {:little_straight, [1, 2, 3, 4, 5]} -> 30
        {:big_straight,    [2, 3, 4, 5, 6]} -> 30
        {:yacht, [d, d, d, d, d]} -> 50
        {_, _} -> 0
      end
  end

  def score(:choice, dice), do: Enum.sum(dice)

  def score(_, _), do: 0

  defp count_face(face, dice) do
    dice
    |> Enum.count(&(&1 == face))
    |> Kernel.*(face)
  end

end
