defmodule Rectangles do
  @moduledoc """
  Counts the rectangles in an ASCII drawing made of `+` corners,
  `-` horizontal edges and `|` vertical edges.
  """

  @doc """
  Count the number of ASCII rectangles.
  """
  @spec count(input :: String.t()) :: non_neg_integer()
  def count(input) do
    grid = parse_input(input)
    corners = for {coord, ?+} <- grid, do: coord

    for top_left <- corners, bottom_right <- corners, rectangle?(grid, top_left, bottom_right), reduce: 0 do
      acc -> acc + 1
    end
  end

  defp rectangle?(grid, {x1, y1}, {x2, y2}) when x1 < x2 and y1 < y2 do
    xs = (x1 + 1)..(x2 - 1)//1
    ys = (y1 + 1)..(y2 - 1)//1

    corner?(grid, {x2, y1}) and corner?(grid, {x1, y2}) and
      edge?(grid, xs, y1..y1, ?-) and edge?(grid, xs, y2..y2, ?-) and
      edge?(grid, x1..x1, ys, ?|) and edge?(grid, x2..x2, ys, ?|)
  end
  defp rectangle?(_grid, _top_left, _bottom_right), do: false

  defp corner?(grid, coord), do: grid[coord] == ?+

  defp edge?(grid, xs, ys, line_char), do: Enum.all?(for(x <- xs, y <- ys, do: {x, y}), &(grid[&1] in [line_char, ?+]))

  defp parse_input(input) do
    for {line, y} <- input |> String.split("\n") |> Enum.with_index(),
        {char, x} <- line |> String.to_charlist() |> Enum.with_index(),
        into: %{},
        do: {{x, y}, char}
  end
end
