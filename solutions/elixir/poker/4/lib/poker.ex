defmodule Poker do
  @ranks ~w(2 3 4 5 6 7 8 9 10 J Q K A)
  @suits ~w(C D H S)
  @rank_ace 14
  @cards_by_string (for {rank_str, rank} <- Enum.with_index(@ranks, 2),
                         suit <- @suits,
                         into: %{} do
                      {rank_str <> suit, {rank, suit}}
                    end)

  @spec best_hand([[String.t()]]) :: [[String.t()]]
  def best_hand(hands) do
    hands
    |> Enum.map(&{value(&1), &1})
    |> Enum.group_by(&elem(&1, 0), &elem(&1, 1))
    |> Enum.max_by(&elem(&1, 0))
    |> elem(1)
  end

  defp value(hand) do
    hand
    |> properties_of_hand()
    |> classify()
  end

  defp properties_of_hand(hand) do
    cards = Enum.map(hand, &card/1)
    cards
    |> descending_ranks_by_cardinality()
    |> may_add_flush_suit(cards)
  end

  defp card(card_string), do: Map.fetch!(@cards_by_string, card_string)

  defp descending_ranks_by_cardinality(cards) do
    cards
    |> Enum.map(fn {rank, _suit} -> rank end)
    |> Enum.frequencies()
    |> Enum.group_by(fn {_rank, count} -> count end, fn {rank, _count} -> rank end)
    |> Enum.map(fn {count, ranks} -> {count, Enum.sort(ranks, :desc)} end)
    |> Map.new()
  end

  defp may_add_flush_suit(properties, [{_, s}, {_, s}, {_, s}, {_, s}, {_, s}]), do:
    Map.put(properties, :flush, s)
  defp may_add_flush_suit(properties, _cards), do: properties

  defp classify(%{:flush => _suit, 1 => [r5, r4, r3, r2, r1]})
       when r1 == r2 - 1 and r2 == r3 - 1 and r3 == r4 - 1 and r4 == r5 - 1, do: {8, [r5]}
  defp classify(%{:flush => _suit, 1 => [@rank_ace, 5, 4, 3, 2]}), do: {8, [5]}
  defp classify(%{4 => [quad], 1 => [kicker]}), do: {7, [quad, kicker]}
  defp classify(%{3 => [triple], 2 => [pair]}), do: {6, [triple, pair]}
  defp classify(%{:flush => _suit, 1 => ranks}), do: {5, ranks}
  defp classify(%{1 => [r5, r4, r3, r2, r1]})
       when r1 == r2 - 1 and r2 == r3 - 1 and r3 == r4 - 1 and r4 == r5 - 1, do: {4, [r5]}
  defp classify(%{1 => [@rank_ace, 5, 4, 3, 2]}), do: {4, [5]}
  defp classify(%{3 => [triple], 1 => kickers}), do: {3, [triple | kickers]}
  defp classify(%{2 => [p1, p2], 1 => [kicker]}), do: {2, [p1, p2, kicker]}
  defp classify(%{2 => [pair], 1 => kickers}), do: {1, [pair | kickers]}
  defp classify(%{1 => ranks}), do: {0, ranks}
end
