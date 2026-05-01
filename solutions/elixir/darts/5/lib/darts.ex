defmodule Darts do

  def score(impact_coordinates),
    do:
      impact_coordinates
      |> radius()
      |> ring()
      |> points()

  defp radius({x, y}), do: :math.sqrt(x ** 2 + y ** 2)
  defp ring(radius) when radius <= 1,  do: :inner
  defp ring(radius) when radius <= 5,  do: :middle
  defp ring(radius) when radius <= 10, do: :outer
  defp ring(_),                        do: :outside
  defp points(:inner),   do: 10
  defp points(:middle),  do: 5
  defp points(:outer),   do: 1
  defp points(:outside), do: 0

end
