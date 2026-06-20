defmodule BinarySearchTree do

  defstruct [:data, left: nil, right: nil]

  def new(data), do: %__MODULE__{data: data}

  def insert(nil, x), do: new(x)
  def insert(%__MODULE__{data: data, left: l} = node, x) when x <= data, do: %{node | left: insert(l, x)}
  def insert(%__MODULE__{right: r} = node, x), do: %{node | right: insert(r, x)}

  def in_order(node), do: [] |> prepend(node)

  defp prepend(acc, nil), do: acc
  defp prepend(acc, %__MODULE__{left: l, data: data, right: r}), do: acc |> prepend(r) |> then(&[data | &1]) |> prepend(l)
  
end
