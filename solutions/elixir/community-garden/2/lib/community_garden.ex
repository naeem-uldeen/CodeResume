defmodule Plot do
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []), do: Agent.start(&init_state/0, opts)

  def list_registrations(pid), do: Agent.get(pid, &Map.values(&1.plots))

  def register(pid, register_to), do: Agent.get_and_update(pid, &add_plot(&1, register_to))

  def release(pid, plot_id),
    do: Agent.update(pid, &%{&1 | plots: Map.delete(&1.plots, plot_id)})

  def get_registration(pid, plot_id),
    do: Agent.get(pid, &Map.get(&1.plots, plot_id, {:not_found, "plot is unregistered"}))

  defp init_state, do: %{plots: %{}, next_id: 1}

  defp add_plot(%{plots: plots, next_id: id}, register_to) do
    plot = %Plot{plot_id: id, registered_to: register_to}
    {plot, %{plots: Map.put(plots, id, plot), next_id: id + 1}}
  end
end