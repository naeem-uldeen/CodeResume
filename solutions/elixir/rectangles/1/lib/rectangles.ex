defmodule Rectangles do
  @doc """
  Count the number of ASCII rectangles.
  """
  @spec count(input :: String.t()) :: integer
  def count(""), do: 0
  def count(input) do
    grid = parse_input(input)

    # Find all coordinates that contain a '+'
    corners =
      grid
      |> Map.keys()
      |> Enum.filter(fn coord -> grid[coord] == ?+ end)
      |> Enum.sort()

    # Iterate through all pairs of corners, treating them as top-left (x1, y1)
    # and bottom-right (x2, y2).
    for {x1, y1} <- corners,
        {x2, y2} <- corners,
        x1 < x2, # Ensure it's strictly to the right
        y1 < y2, # Ensure it's strictly below
        grid[{x2, y1}] == ?+, # Top-right is a corner
        grid[{x1, y2}] == ?+, # Bottom-left is a corner
        valid_horizontal?(grid, x1, x2, y1), # Top edge is valid
        valid_horizontal?(grid, x1, x2, y2), # Bottom edge is valid
        valid_vertical?(grid, x1, y1, y2),   # Left edge is valid
        valid_vertical?(grid, x2, y1, y2),   # Right edge is valid
        reduce: 0 do
      acc -> acc + 1
    end
  end

  # Helper to turn the multiline string into a map of {x, y} => char_code
  defp parse_input(input) do
    input
    |> String.split("\n")
    |> Enum.with_index()
    |> Enum.flat_map(fn {line, y} ->
      line
      |> String.to_charlist()
      |> Enum.with_index()
      |> Enum.map(fn {char, x} -> {{x, y}, char} end)
    end)
    |> Map.new()
  end

  # Helpers to validate that the edges only contain the correct line characters or intersections.
  # If points are adjacent, the edge is technically valid automatically.
  defp valid_horizontal?(_grid, x1, x2, _y) when x2 <= x1 + 1, do: true
  defp valid_horizontal?(grid, x1, x2, y) do
    Enum.all?((x1 + 1)..(x2 - 1), fn x -> grid[{x, y}] in [?-, ?+] end)
  end

  defp valid_vertical?(_grid, _x, y1, y2) when y2 <= y1 + 1, do: true
  defp valid_vertical?(grid, x, y1, y2) do
    Enum.all?((y1 + 1)..(y2 - 1), fn y -> grid[{x, y}] in [?|, ?+] end)
  end
end
