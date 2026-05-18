defmodule SecretHandshake do
  use Bitwise

  @actions [
    {1, "wink"},
    {2, "double blink"},
    {4, "close your eyes"},
    {8, "jump"}
  ]

  def commands(n) do
    @actions
    |> Enum.filter(fn {bit, _} -> (n &&& bit) != 0 end)
    |> Enum.map(fn {_, action} -> action end)
    |> reverse(n)
  end

  defp reverse(actions, n) when (n &&& 16) != 0, do: Enum.reverse(actions)
  defp reverse(actions, _),                      do: actions

end
