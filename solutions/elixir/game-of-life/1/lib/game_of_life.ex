defmodule GameOfLife do
  @doc """
  Apply the rules of Conway's Game of Life to a grid of 0s (dead) and 1s (alive), returning the next generation.
  """
  @spec tick(matrix :: list(list(0 | 1))) :: list(list(0 | 1))
  def tick([]), do: []
  def tick([first | _] = matrix), do: matrix |> pad(length(first)) |> rows([])

  defp pad(matrix, width), do: [border(width) | Enum.map(matrix, &([0 | &1] ++ [0])) ++ [border(width)]]

  defp border(width), do: List.duplicate(0, width + 2)

  defp rows([above, row, below | rest], acc), do: rows([row, below | rest], [cells(above, row, below, []) | acc])
  defp rows(_fewer_than_three, acc), do: Enum.reverse(acc)

  defp cells([a1, a2, a3 | a_rest], [r1, r2, r3 | r_rest], [b1, b2, b3 | b_rest], acc), do: cells([a2, a3 | a_rest], [r2, r3 | r_rest], [b2, b3 | b_rest], [next(r2, a1 + a2 + a3 + r1 + r3 + b1 + b2 + b3) | acc])
  defp cells(_above, _row, _below, acc), do: Enum.reverse(acc)

  defp next(1, 2), do: 1
  defp next(_cell, 3), do: 1
  defp next(_cell, _neighbors), do: 0
end
