defmodule Prism do
  @doc """
  Finds the sequence of prisms that the laser will hit.
  """
  @tolerance 0.05
  @type start :: %{angle: number(), x: number(), y: number()}
  @type prism :: %{id: integer(), angle: number(), x: number(), y: number()}

  @spec find_sequence(prisms :: [prism()], start :: start()) :: [integer()]
  def find_sequence(prisms, %{x: x, y: y, angle: angle}), do: trace(prisms, x, y, angle, [])

  defp trace(prisms, x, y, heading, acc), do: prisms |> next_hit(x, y, heading) |> step(prisms, heading, acc)

  defp step(nil, _prisms, _heading, acc), do: Enum.reverse(acc)
  defp step({_along, _across, prism}, prisms, heading, acc), do: trace(prisms, prism.x, prism.y, heading + prism.angle, [prism.id | acc])

  defp next_hit(prisms, x, y, heading), do: prisms |> measure(x, y, direction(heading)) |> Enum.filter(&on_ray?/1) |> Enum.min_by(&elem(&1, 0), &<=/2, fn -> nil end)

  defp direction(heading), do: {:math.cos(heading * :math.pi() / 180), :math.sin(heading * :math.pi() / 180)}

  defp measure(prisms, x, y, direction), do: Enum.map(prisms, &project(&1, x, y, direction))

  defp project(prism, x, y, {dx, dy}), do: {(prism.x - x) * dx + (prism.y - y) * dy, (prism.x - x) * dy - (prism.y - y) * dx, prism}

  defp on_ray?({along, across, _prism}) when along > @tolerance and abs(across) < @tolerance, do: true
  defp on_ray?(_miss), do: false
end
