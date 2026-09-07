defmodule KillerSudokuHelper do
  @doc """
  Returns all sorted combinations of distinct digits from 1 through 9
  that have the requested size and sum, excluding the given digits.
  """
  @spec combinations(%{
          exclude: [integer()],
          size: non_neg_integer(),
          sum: integer()
        }) :: [[integer()]]
  def combinations(%{exclude: exclude, size: size, sum: sum})
      when size >= 0 do
    digits =
      1..9
      |> Enum.reject(&(&1 in exclude))

    find_combinations(digits, size, sum)
  end

  def combinations(_cage), do: []

  defp find_combinations(_digits, 0, 0), do: [[]]
  defp find_combinations(_digits, 0, _sum), do: []
  defp find_combinations([], _size, _sum), do: []
  defp find_combinations([digit | rest], size, sum)
       when size > 0 and sum >= digit do
    including_digit =
      rest
      |> find_combinations(size - 1, sum - digit)
      |> Enum.map(&[digit | &1])
    excluding_digit = find_combinations(rest, size, sum)
    including_digit ++ excluding_digit
  end
  defp find_combinations([_digit | rest], size, sum) do
    find_combinations(rest, size, sum)
  end
end
