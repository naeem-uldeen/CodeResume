defmodule Darts do

  def score(impact_coordinates),
    do:
      impact_coordinates
      |> zone()
      |> points()

  defp zone({x, y}), do: ring(:math.sqrt(x**2 + y**2))

  defp ring(radius) when radius <= 1,  do: :inner
  defp ring(radius) when radius <= 5,  do: :middle
  defp ring(radius) when radius <= 10, do: :outer
  defp ring(_),                        do: :outside

  defp points(:inner),   do: 10
  defp points(:middle),  do: 5
  defp points(:outer),   do: 1
  defp points(:outside), do: 0
  
end
