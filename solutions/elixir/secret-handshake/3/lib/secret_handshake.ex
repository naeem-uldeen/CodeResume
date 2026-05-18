defmodule SecretHandshake do
  import Bitwise

  @actions ["wink", "double blink", "close your eyes", "jump"]

  def commands(n) do
    @actions
    |> Enum.with_index()
    |> Enum.filter(fn {_, i} -> (n >>> i &&& 1) == 1 end)
    |> Enum.map(fn {action, _} -> action end)
    |> reverse(n)
  end

  defp reverse(actions, n) when (n &&& 16) != 0, do: Enum.reverse(actions)
  defp reverse(actions, _),                      do: actions
  
end
