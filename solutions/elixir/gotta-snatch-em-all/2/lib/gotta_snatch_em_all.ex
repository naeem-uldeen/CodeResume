defmodule GottaSnatchEmAll do

  @type card :: String.t()
  @type collection :: MapSet.t(card())

  def new_collection(card), do: MapSet.new([card])

  def add_card(card, collection),
    do: {MapSet.member?(collection, card), MapSet.put(collection, card)}

  def trade_card(yours, theirs, collection) do
    {MapSet.member?(collection, yours) and
    not MapSet.member?(collection, theirs),
    collection
    |> MapSet.delete(yours)
    |> MapSet.put(theirs)}
  end

  def remove_duplicates(cards),
    do: MapSet.to_list(MapSet.new(cards))

  def extra_cards(yours, theirs), do:
    MapSet.size(MapSet.difference(yours, theirs))

  def boring_cards([]), do: []
  def boring_cards(collections) do
    collections
    |> Enum.reduce(&MapSet.intersection/2)
    |> MapSet.to_list()
  end

  def total_cards(collections) do
    collections
    |> Enum.reduce(MapSet.new(), &MapSet.union(&2, &1))
    |> MapSet.size()
  end

  def split_shiny_cards(collection) do
    collection
    |> MapSet.to_list()
    |> Enum.split_with(&String.starts_with?(&1, "Shiny "))
  end

end
