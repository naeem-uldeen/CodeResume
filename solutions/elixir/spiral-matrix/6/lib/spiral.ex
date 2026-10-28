defmodule Spiral do
  @doc """
  Given the dimension, return a square matrix of numbers in clockwise spiral order.
  """
  @spec matrix(size :: integer) :: list(list(integer))
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

  defp rightward_inward_spiral_from_top_left(
         cells,
         {coord, direction, value} \\ {{0, -1}, {0, 1}, 1}
       ) do
    case next_empty_cell(cells, coord, direction) do
      {coord, direction} ->
        %{cells | coord => value}
        |> rightward_inward_spiral_from_top_left({coord, direction, value + 1})

      nil ->
        cells
    end
  end

  defp next_empty_cell(cells, coord, direction) do
    next_coord = go_straight(coord, direction)

    if cells[next_coord] == :empty do
      {next_coord, direction}
    else
      direction = turn_right(direction)
      next_coord = go_straight(coord, direction)

      if cells[next_coord] == :empty do
        {next_coord, direction}
      end
    end
  end

  defp go_straight({row, column}, {d_row, d_column}), do: {row + d_row, column + d_column}

  defp turn_right({d_row, d_column}), do: {d_column, -d_row}

  defp to_list_of_lists(cells, square_width) do
    for row <- 0..(square_width - 1) do
      for column <- 0..(square_width - 1), do: cells[{row, column}]
    end
  end
end
