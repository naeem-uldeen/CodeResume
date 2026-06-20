defmodule BinarySearchTree do

  @type t :: %__MODULE__{data: any, left: t, right: t} | nil

  defstruct [:data, left: nil, right: nil]

  def new(data), do: %__MODULE__{data: data}

  def insert(nil, x), do: new(x)
  def insert(%__MODULE__{data: d, left: l} = node, x) when x <= d, do: %{node | left: insert(l, x)}
  def insert(%__MODULE__{right: r} = node, x), do: %{node | right: insert(r, x)}

  def in_order(tree), do: [] |> prepend(tree)

  defp prepend(acc, nil), do: acc
  defp prepend(acc, %__MODULE__{left: l, data: data, right: r}), do: acc |> prepend(r) |> cons(data) |> prepend(l)

  defp cons(list, item), do: [item | list]
  
end
