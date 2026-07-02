defmodule TakeANumber do

  def start(), do: spawn(fn -> loop(0) end)

  defp loop(state) do
    receive do
      {:report_state, sender} ->
        send(sender, state)
        loop(state)

      {:take_a_number, sender} ->
        new_state = state + 1
        send(sender, new_state)
        loop(new_state)

      :stop -> :ok
      _unexpected -> loop(state)
    end
  end
  
end

