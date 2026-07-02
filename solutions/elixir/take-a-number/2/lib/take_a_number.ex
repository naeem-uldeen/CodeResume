defmodule TakeANumber do

  def start(), do: spawn(fn -> serve_numbers(0) end)
  
  defp serve_numbers(last_number) do
    receive do
      {:report_state, sender} ->
        send(sender, last_number)
        serve_numbers(last_number)
      
      {:take_a_number, sender} ->
        next_number = last_number + 1
        send(sender, next_number)
        serve_numbers(next_number)
      
      :stop -> :ok
      _unexpected -> serve_numbers(last_number)
    end
  end
  
end
