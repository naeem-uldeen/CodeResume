defmodule KillerSudokuHelper do
  @all_numbers Enum.to_list(1..9)

  @doc """
  Return the possible combinations of `size` distinct numbers from 1-9,
  excluding `exclude`, that sum up to `sum`.
  """
  @spec combinations(cage :: %{exclude: [integer], size: integer, sum: integer}) :: [[integer]]
  def combinations(%{exclude: excluded, size: size, sum: sum})
      when is_list(excluded) and size > 0 and sum > 0,
      do: combinations(@all_numbers -- excluded, size, sum)

  defp combinations(numbers, 1, sum), do: if(sum in numbers, do: [[sum]], else: [])
  defp combinations([number | _], size, sum)
       when size * number + div(size * (size - 1), 2) > sum, do: []
  defp combinations(numbers, size, _sum) when length(numbers) < size, do: []
  defp combinations([number | numbers], size, sum),
    do: Enum.map(combinations(numbers, size - 1, sum - number), &[number | &1]) ++ combinations(numbers, size, sum)
end
