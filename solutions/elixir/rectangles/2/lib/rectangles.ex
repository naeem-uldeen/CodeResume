defmodule Rectangles do
  @doc """
  Count the number of ASCII rectangles.
  """
  @spec count(input :: String.t()) :: integer
  def count(input) do
    grid = parse_input(input)
    corners = Enum.sort(for {coord, ?+} <- grid, do: coord)

    for {x1, y1} <- corners,
        {x2, y2} <- corners,
        x1 < x2,
        y1 < y2,
        grid[{x2, y1}] == ?+,
        grid[{x1, y2}] == ?+,
        valid_horizontal?(grid, x1, x2, y1),
        valid_horizontal?(grid, x1, x2, y2),
        valid_vertical?(grid, x1, y1, y2),
        valid_vertical?(grid, x2, y1, y2),
        reduce: 0 do
      acc -> acc + 1
    end
  end

  defp parse_input(input) do
    for {line, y} <- input |> String.split("\n") |> Enum.with_index(),
        {char, x} <- line |> String.to_charlist() |> Enum.with_index(),
        into: %{},
        do: {{x, y}, char}
  end

  defp valid_horizontal?(grid, x1, x2, y),
    do: Enum.all?((x1 + 1)..(x2 - 1)//1, fn x -> grid[{x, y}] in [?-, ?+] end)

  defp valid_vertical?(grid, x, y1, y2),
    do: Enum.all?((y1 + 1)..(y2 - 1)//1, fn y -> grid[{x, y}] in [?|, ?+] end)
end
