defmodule PascalsTriangle do

  def rows(0), do: []
  def rows(n), do: build(n, [[1]])

  defp build(1, triangle), do: Enum.reverse(triangle)
  defp build(n, [last | _] = triangle),
    do: build(n - 1, [next_row(last, [1]) | triangle])

  defp next_row([_], acc), do: Enum.reverse([1 | acc])
  defp next_row([a, b | rest], acc),
    do: next_row([b | rest], [a + b | acc])

end
