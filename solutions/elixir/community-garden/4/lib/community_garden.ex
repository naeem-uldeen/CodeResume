defmodule Plot do
  defstruct [:plot_id, :registered_to]
end

defmodule PlotRegistry do
  def new, do: %{__last_id__: 0}

  def register(registry, register_to) do
    id = registry.__last_id__ + 1
    plot = %Plot{plot_id: id, registered_to: register_to}

    registry =
      registry
      |> Map.put(:__last_id__, id)
      |> Map.put(id, plot)

    {plot, registry}
  end

  def release(registry, plot_id), do: Map.delete(registry, plot_id)

  def all(registry), do: for({_id, %Plot{} = plot} <- registry, do: plot)

  def get(registry, plot_id, default \\ nil), do: Map.get(registry, plot_id, default)
end

defmodule CommunityGarden do
  def start(opts \\ []), do: Agent.start(&PlotRegistry.new/0, opts)

  def list_registrations(pid), do: Agent.get(pid, &PlotRegistry.all/1)

  def register(pid, register_to),
    do: Agent.get_and_update(pid, &PlotRegistry.register(&1, register_to))

  def release(pid, plot_id),
    do: Agent.update(pid, &PlotRegistry.release(&1, plot_id))

  def get_registration(pid, plot_id),
    do: Agent.get(pid, &PlotRegistry.get(&1, plot_id, {:not_found, "plot is unregistered"}))
end
