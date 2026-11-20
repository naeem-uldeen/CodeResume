defmodule GameOfLife do
  @spec tick(matrix :: list(list(0 | 1))) :: list(list(0 | 1))
  def tick([]), do: []
  def tick([first | _] = matrix) do
    matrix
    |> pad(length(first))
    |> Enum.chunk_every(3, 1, :discard)
    |> Enum.map(&next_row/1)
  end

  defp pad(matrix, width), do: matrix |> Enum.map(&frame(&1, 0)) |> frame(List.duplicate(0, width + 2))

  defp frame(list, edge), do: frame(list, edge, [edge])
  defp frame([], edge, acc), do: Enum.reverse([edge | acc])
  defp frame([item | rest], edge, acc), do: frame(rest, edge, [item | acc])

  defp next_row(three_rows) do
    three_rows
    |> Enum.zip()
    |> Enum.chunk_every(3, 1, :discard)
    |> Enum.map(&next_cell/1)
  end

  defp next_cell([{a1, r1, b1}, {a2, cell, b2}, {a3, r3, b3}]),
    do: next(cell, a1 + a2 + a3 + r1 + r3 + b1 + b2 + b3)

  defp next(1, 2), do: 1
  defp next(_cell, 3), do: 1
  defp next(_cell, _neighbors), do: 0
end
