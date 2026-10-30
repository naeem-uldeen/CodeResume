defmodule SaddlePoints do
  @doc """
  Calculates all the saddle points from a string
  representation of a matrix
  """
  @spec saddle_points(String.t()) :: [{pos_integer, pos_integer}]
  def saddle_points(input) do
    rows = rows(input)
    cols = transposition(rows)

    intersection(max_points_in_rows(rows), min_points_in_cols(cols))
  end

  @doc """
  Parses a string representation of a matrix
  to a list of rows
  """
  @spec rows(String.t()) :: [[integer]]
  def rows(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn row -> row |> String.split() |> Enum.map(&String.to_integer/1) end)
  end

  @doc """
  Parses a string representation of a matrix
  to a list of columns
  """
  @spec columns(String.t()) :: [[integer]]
  def columns(input), do: transposition(rows(input))

  defp transposition(matrix), do: Enum.map(Enum.zip(matrix), &Tuple.to_list/1)

  defp intersection(enum1, enum2) do
    set = MapSet.new(enum2)
    Enum.filter(enum1, &MapSet.member?(set, &1))
  end

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
