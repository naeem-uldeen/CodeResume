defmodule TakeANumberDeluxe do
  use GenServer

  @default_timeout :infinity

  @spec start_link(keyword()) :: {:ok, pid()} | {:error, atom()}
  def start_link(init_arg) do
    with {:ok, state} <-
           TakeANumberDeluxe.State.new(
             init_arg[:min_number],
             init_arg[:max_number],
             init_arg[:auto_shutdown_timeout] || @default_timeout
           ) do
      GenServer.start_link(__MODULE__, state)
    end
  end

  @spec report_state(pid()) :: TakeANumberDeluxe.State.t()
  def report_state(machine), do: GenServer.call(machine, :report_state)

  @spec queue_new_number(pid()) :: {:ok, integer()} | {:error, atom()}
  def queue_new_number(machine), do: GenServer.call(machine, :queue_new_number)

  @spec serve_next_queued_number(pid(), integer() | nil) :: {:ok, integer()} | {:error, atom()}
  def serve_next_queued_number(machine, priority_number \\ nil), do: GenServer.call(machine, {:serve_next_queued_number, priority_number})

  @spec reset_state(pid()) :: :ok
  def reset_state(machine), do: GenServer.cast(machine, :reset_state)

  @impl true
  def init(state), do: {:ok, state, state.auto_shutdown_timeout}

  @impl true
  def handle_call(:report_state, _from, state), do: {:reply, state, state, state.auto_shutdown_timeout}
  def handle_call(:queue_new_number, _from, state) do
    timeout = state.auto_shutdown_timeout
    case TakeANumberDeluxe.State.queue_new_number(state) do
      {:ok, number, new_state} ->
        {:reply, {:ok, number}, new_state, timeout}
      {:error, reason} ->
        {:reply, {:error, reason}, state, timeout}
    end
  end

  @impl true
  def handle_call({:serve_next_queued_number, priority_number}, _from, state) do
    timeout = state.auto_shutdown_timeout
    case TakeANumberDeluxe.State.serve_next_queued_number(state, priority_number) do
      {:ok, number, new_state} ->
        {:reply, {:ok, number}, new_state, timeout}
      {:error, reason} ->
        {:reply, {:error, reason}, state, timeout}
    end
  end

  @impl true
  def handle_cast(:reset_state, state) do
    {:ok, new_state} =
      TakeANumberDeluxe.State.new(
        state.min_number,
        state.max_number,
        state.auto_shutdown_timeout
      )
    {:noreply, new_state, new_state.auto_shutdown_timeout}
  end

  @impl true
  def handle_info({:hello, "there"}, state), do: {:noreply, state, state.auto_shutdown_timeout}
  def handle_info(:timeout, state), do: {:stop, :normal, state}
  
end
