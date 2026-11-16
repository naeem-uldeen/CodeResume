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

  defp on_trajectory?(prism, beam), do: prism |> offsets_from(beam) |> ahead_and_aligned?()

  defp ahead_and_aligned?({along, across}) when along > @tolerance and abs(across) < @tolerance, do: true
  defp ahead_and_aligned?(_miss), do: false

  defp offsets_from(%{x: x1, y: y1}, %{x: x0, y: y0, angle: angle}) do
    {dx, dy} = {x1 - x0, y1 - y0}
    {cos, sin} = {:math.cos(angle * :math.pi() / 180), :math.sin(angle * :math.pi() / 180)}
    {dx * cos + dy * sin, dx * sin - dy * cos}
  end

  defp distance(%{x: x1, y: y1}, %{x: x0, y: y0}), do: :math.sqrt((x1 - x0) ** 2 + (y1 - y0) ** 2)
end
