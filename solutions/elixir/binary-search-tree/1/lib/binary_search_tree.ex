defmodule BinarySearchTree do

  @type t :: %{data: any, left: t | nil, right: t | nil}

  def new(data), do: %{data: data, left: nil, right: nil}

  def insert(%{data: data, left: l} = node, x) when x <= data, do: %{node | left: put(l, x)}
  def insert(%{right: r} = node, x), do: %{node | right: put(r, x)}

  defp put(nil, x), do: new(x)
  defp put(t, x), do: insert(t, x)

  def in_order(node), do: in_order(node, [])

  defp in_order(nil, acc), do: acc
  defp in_order(%{left: l, data: data, right: r}, acc), do: in_order(l, [data | in_order(r, acc)])
  
end
