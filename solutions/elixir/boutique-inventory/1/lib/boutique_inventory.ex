defmodule BoutiqueInventory do

  def sort_by_price(inventory),
    do: Enum.sort_by(inventory, &Map.fetch(&1, :price))

  def with_missing_price(inventory),
    do: Enum.filter(inventory, fn item -> is_nil(item.price) end)

  def update_names(inventory, old_word, new_word),
    do: Enum.map(inventory, &update_name(&1, old_word, new_word))

  def increase_quantity(item, count),
    do: Map.update!(item, :quantity_by_size, &increase_by(&1, count))

  def total_quantity(%{quantity_by_size: qbs}),
    do: Enum.sum(Map.values(qbs))

  defp update_name(item, old_word, new_word),
    do: %{item | name: String.replace(item.name, old_word, new_word)}

  defp increase_by(sizes, count),
    do: Map.new(sizes, fn {size, quantity} -> {size, quantity + count} end)
    
end
