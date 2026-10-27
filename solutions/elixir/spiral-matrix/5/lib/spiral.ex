defmodule Spiral do
  def matrix(0), do: []
  def matrix(square_width) when square_width in 1..1_000,
    do:
      square_width
      |> empty_square_map()
      |> rightward_inward_spiral_from_top_left()
      |> to_list_of_lists(square_width)

  defp empty_square_map(square_width) do
    for row <- 0..(square_width - 1), column <- 0..(square_width - 1), into: %{} do
      {{row, column}, :empty}
    end
  end

  defp rightward_inward_spiral_from_top_left(cells, walker \\ {{0, -1}, {0, 1}, 1})
  defp rightward_inward_spiral_from_top_left(cells, {coord, direction, value}),
    do: step(next_empty_cell(cells, coord, direction), cells, value)

  defp step(nil, cells, _value), do: cells
  defp step({coord, direction}, cells, value) do
    cells
    |> Map.put(coord, value)
    |> rightward_inward_spiral_from_top_left({coord, direction, value + 1})
  end

  defp next_empty_cell(cells, coord, direction) do
    [direction, turn_right(direction)]
    |> Enum.map(&{move(coord, &1), &1})
    |> Enum.find(fn {ahead, _direction} -> cells[ahead] == :empty end)
  end

  defp move({row, column}, {d_row, d_column}), do: {row + d_row, column + d_column}

  defp turn_right({d_row, d_column}), do: {d_column, -d_row}

  defp to_list_of_lists(cells, square_width) do
    for row <- 0..(square_width - 1) do
      for column <- 0..(square_width - 1), do: cells[{row, column}]
    end
  end
end
