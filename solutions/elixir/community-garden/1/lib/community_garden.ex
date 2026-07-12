defmodule Plot do
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []) do
    Agent.start(fn -> %{plots: %{}, next_id: 1} end, opts)
  end

  def list_registrations(pid) do
    Agent.get(pid, fn %{plots: plots} -> Map.values(plots) end)
  end

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn %{plots: plots, next_id: next_id} ->
      plot = %Plot{plot_id: next_id, registered_to: register_to}
      {plot, %{plots: Map.put(plots, next_id, plot), next_id: next_id + 1}}
    end)
  end

  def release(pid, plot_id) do
    Agent.update(pid, fn %{plots: plots} = state ->
      %{state | plots: Map.delete(plots, plot_id)}
    end)
  end

  def get_registration(pid, plot_id) do
    Agent.get(pid, fn %{plots: plots} ->
      Map.get(plots, plot_id, {:not_found, "plot is unregistered"})
    end)
  end
end
