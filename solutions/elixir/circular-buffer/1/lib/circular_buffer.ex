defmodule CircularBuffer do
  def new(capacity), do: Agent.start_link(fn -> {capacity, []} end)

  def read(buffer), do: Agent.get_and_update(buffer, &take/1)

  def write(buffer, item), do: Agent.get_and_update(buffer, &put(&1, item))

  def overwrite(buffer, item), do: Agent.update(buffer, &force(&1, item))

  def clear(buffer), do: Agent.update(buffer, &wipe/1)

  defp take({capacity, []}), do: {{:error, :empty}, {capacity, []}}
  defp take({capacity, [oldest | rest]}), do: {{:ok, oldest}, {capacity, rest}}

  defp put({capacity, items}, _item) when length(items) >= capacity,
    do: {{:error, :full}, {capacity, items}}
  defp put({capacity, items}, item), do: {:ok, {capacity, items ++ [item]}}

  defp force({capacity, [_oldest | rest] = items}, item) when length(items) >= capacity,
    do: {capacity, rest ++ [item]}
  defp force({capacity, items}, item), do: {capacity, items ++ [item]}

  defp wipe({capacity, _items}), do: {capacity, []}
end
