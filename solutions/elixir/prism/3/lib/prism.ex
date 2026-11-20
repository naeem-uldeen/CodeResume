defmodule Prism do
  @tolerance 0.05
  @type beam :: %{angle: number(), x: number(), y: number()}
  @type prism :: %{id: integer(), angle: number(), x: number(), y: number()}

  @doc """
  Finds the sequence of prisms that the laser will hit.
  """
  @spec find_sequence(prisms :: [prism()], beam :: beam()) :: [integer()]
  def find_sequence(prisms, beam), do: hit_prisms(closest_prism_on_trajectory(beam, prisms), beam, prisms, [])

  defp hit_prisms(nil, _beam, _prisms, hit_prism_ids), do: Enum.reverse(hit_prism_ids)
  defp hit_prisms(%{id: id} = prism, beam, prisms, hit_prism_ids) do
    refracted = refract_at(beam, prism)
    hit_prisms(closest_prism_on_trajectory(refracted, prisms), refracted, prisms, [id | hit_prism_ids])
  end

  defp refract_at(%{angle: angle}, %{x: x, y: y, angle: deflection}), do: %{x: x, y: y, angle: angle + deflection}

  defp closest_prism_on_trajectory(beam, prisms), do: prisms |> Enum.filter(&on_trajectory?(&1, beam)) |> Enum.min_by(&distance(&1, beam), fn -> nil end)

  defp on_trajectory?(%{x: x1, y: y1}, %{angle: angle, x: x0, y: y0}),
    do:
      with(
        a = y1 - y0,
        b = x1 - x0,
        c = :math.sqrt(a * a + b * b),
        phi = :math.pi() * angle / 180,
        do:
          c != 0.0 &&
            abs(:math.sin(phi) - a / c) <= @tolerance &&
            abs(:math.cos(phi) - b / c) <= @tolerance
      )

  defp distance(%{x: x1, y: y1}, %{x: x0, y: y0}), do: :math.sqrt((x1 - x0) ** 2 + (y1 - y0) ** 2)
end
