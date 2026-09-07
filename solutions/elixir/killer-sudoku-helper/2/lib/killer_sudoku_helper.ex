defmodule KillerSudokuHelper do
  @doc """
  Return the possible combinations of `size` distinct numbers from 1-9,
  excluding `exclude`, that sum up to `sum`.
  """
  @spec combinations(cage :: %{exclude: [integer], size: integer, sum: integer}) :: [[integer]]
  def combinations(%{exclude: exclude, size: size, sum: sum}),
    do:
      1..9
      |> Enum.reject(fn digit -> digit in exclude end)
      |> choose(size)
      |> Enum.filter(fn combination -> Enum.sum(combination) == sum end)
      |> Enum.sort()

  defp choose(digits, size), do: find_combinations([{digits, size, []}], [])

  defp find_combinations([], acc), do: acc
  defp find_combinations([{_digits, 0, current} | rest], acc), do: find_combinations(rest, [Enum.reverse(current) | acc])
  defp find_combinations([{[], _size, _current} | rest], acc), do: find_combinations(rest, acc)
  defp find_combinations([{[digit | tail], size, current} | rest], acc) do
    take = {tail, size - 1, [digit | current]}
    skip = {tail, size, current}
    find_combinations([take, skip | rest], acc)
  end
end
