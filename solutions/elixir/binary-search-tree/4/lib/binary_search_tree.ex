defmodule BinarySearchTree do

  defstruct [:data, left: nil, right: nil]

  def new(data), do: %__MODULE__{data: data}

  def insert(nil, data), do: new(data)
  def insert(%__MODULE__{data: pivot} = tree, data) when data <= pivot,
    do: Map.update(tree, :left, new(data), &insert(&1, data))
  def insert(%__MODULE__{} = tree, data),
    do: Map.update(tree, :right, new(data), &insert(&1, data))

  def in_order(tree), do: [] |> prepend(tree)

  defp prepend(in_order, nil), do: in_order
  defp prepend(in_order, %__MODULE__{data: data, left: left, right: right}),
    do:
      in_order
      |> prepend(right)
      |> prepend(data)
      |> prepend(left)
  defp prepend(in_order, data), do: [data | in_order]

end
