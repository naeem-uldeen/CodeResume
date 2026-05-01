defmodule Darts do

  @rings [
    {:radius_lte, 1,  :inner},
    {:radius_lte, 5,  :middle},
    {:radius_lte, 10, :outer}
  ]

  def score({x, y}),      do: {x, y} |> zone() |> points()

  defp zone(coordinates), do: coordinates |> radius() |> ring()
  defp radius({x, y}),    do: :math.sqrt(x*x + y*y)

  defp ring(radius) do
    Enum.find_value(@rings, :outside, fn
      {_, limit, zone} when radius <= limit -> zone
      _ -> false
    end)
  end

  defp points(:inner),   do: 10
  defp points(:middle),  do: 5
  defp points(:outer),   do: 1
  defp points(:outside), do: 0

end
