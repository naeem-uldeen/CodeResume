defmodule KillerSudokuHelper do
  @doc """
  Return the possible combinations of `size` distinct numbers from 1-9,
  excluding `exclude`, that sum up to `sum`.
  """
  @spec combinations(cage :: %{exclude: [integer], size: integer, sum: integer}) :: [[integer]]
  def combinations(%{exclude: exclude, size: size, sum: sum}) when size > 0 do
    1..9
    |> Enum.reject(&(&1 in exclude))
    |> combine(size, sum)
  end

  defp combine([], _size, _sum), do: []
  defp combine(numbers, 1, sum), do: if sum in numbers, do: [[sum]], else: []
  defp combine([digit | rest], size, sum) when size > 1 do
    cheapest_remaining_sum = Enum.take(rest, size - 1) |> Enum.sum()
    if length(rest) < size - 1 or digit + cheapest_remaining_sum > sum do
      []
    else
      including_digit = for combination <- combine(rest, size - 1, sum - digit), do: [digit | combination]
      excluding_digit = combine(rest, size, sum)
      including_digit ++ excluding_digit
    end
  end
end
