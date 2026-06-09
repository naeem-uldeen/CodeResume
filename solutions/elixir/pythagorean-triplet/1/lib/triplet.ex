defmodule Triplet do

  def sum(triplet), do: Enum.sum(triplet)
  def product(triplet), do: Enum.reduce(triplet, 1, &*/2)
  def pythagorean?([a, b, c]), do: (a * a) + (b * b) == c * c

  def generate(sum), do: generate(sum, 1, [])

  defp generate(sum, a, acc) when a * 3 >= sum, do: Enum.reverse(acc)
  defp generate(sum, a, acc), do: generate(sum, a + 1, try_triplet(sum, a, acc))

  defp try_triplet(sum, a, acc) when rem(sum * (sum - 2 * a), 2 * (sum - a)) != 0, do: acc
  defp try_triplet(sum, a, acc) do
    b = div(sum * (sum - 2 * a), 2 * (sum - a))
    collect_if_ordered(sum, a, b, acc)
  end

  defp collect_if_ordered(sum, a, b, acc) when b > a do
    triplet = [a, b, sum - a - b]
    collect(triplet, acc, pythagorean?(triplet))
  end
  defp collect_if_ordered(_sum, _a, _b, acc), do: acc

  defp collect(triplet, acc, true), do: [triplet | acc]
  defp collect(_triplet, acc, false), do: acc

end
