defmodule SaddlePoints do
  @type point :: {pos_integer, pos_integer}

  @spec saddle_points(String.t()) :: [point()]
  def saddle_points(input) when is_binary(input) do
    rows = rows(input)
    cols = transposition(rows)

    intersection(max_points_in_rows(rows), min_points_in_cols(cols))
  end

  @spec rows(String.t()) :: [[integer]]
  def rows(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn row -> row
    |> String.split()
    |> Enum.map(&String.to_integer/1) end)
  end

  @spec columns(String.t()) :: [[integer]]
  def columns(input), do: transposition(rows(input))

  defp transposition(matrix), do: Enum.map(Enum.zip(matrix), &Tuple.to_list/1)

  defp intersection(points1, points2),
    do: Enum.filter(points1, &Enum.member?(points2, &1))

  defp max_points_in_rows(rows), do: extreme_points(rows, &Enum.max/1)

  defp min_points_in_cols(cols) do
    for {c, r} <- extreme_points(cols, &Enum.min/1), do: {r, c}
  end

  defp extreme_points(lines, extreme) do
    for {line, i} <- Enum.with_index(lines, 1),
        target = extreme.(line),
        {^target, j} <- Enum.with_index(line, 1),
        do: {i, j}
  end
end
