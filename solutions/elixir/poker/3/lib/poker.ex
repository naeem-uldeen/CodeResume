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
    |> Enum.group_by(&score/1)
    |> Enum.max_by(fn {score, _hands} -> score end)
    |> elem(1)
  end

  defp score(hand) do
    hand
    |> Enum.map(&parse_card/1)
    |> properties_of_hand()
    |> value()
  end

  defp parse_card(card), do: Map.fetch!(@cards_by_string, card)

  defp properties_of_hand(cards) do
    cards
    |> Enum.map(fn {rank, _suit} -> rank end)
    |> Enum.frequencies()
    |> Enum.group_by(fn {_rank, count} -> count end, fn {rank, _count} -> rank end)
    |> Enum.map(fn {count, ranks} -> {count, Enum.sort(ranks, :desc)} end)
    |> Map.new()
    |> maybe_put_flush(cards)
  end

  defp maybe_put_flush(properties, [{_, s}, {_, s}, {_, s}, {_, s}, {_, s}]), do:
    Map.put(properties, :flush, s)
  defp maybe_put_flush(properties, _cards), do: properties

  defp value(%{:flush => _suit, 1 => [r5, r4, r3, r2, r1]})
       when r1 == r2 - 1 and r2 == r3 - 1 and r3 == r4 - 1 and r4 == r5 - 1 do
    {8, [r5]}
  end
  defp value(%{:flush => _suit, 1 => [@rank_ace, 5, 4, 3, 2]}), do: {8, [5]}
  defp value(%{4 => [quad], 1 => [kicker]}), do: {7, [quad, kicker]}
  defp value(%{3 => [triple], 2 => [pair]}), do: {6, [triple, pair]}
  defp value(%{:flush => _suit, 1 => ranks}), do: {5, ranks}
  defp value(%{1 => [r5, r4, r3, r2, r1]})
       when r1 == r2 - 1 and r2 == r3 - 1 and r3 == r4 - 1 and r4 == r5 - 1 do
    {4, [r5]}
  end
  defp value(%{1 => [@rank_ace, 5, 4, 3, 2]}), do: {4, [5]}
  defp value(%{3 => [triple], 1 => kickers}), do: {3, [triple | kickers]}
  defp value(%{2 => [p1, p2], 1 => [kicker]}), do: {2, [p1, p2, kicker]}
  defp value(%{2 => [pair], 1 => kickers}), do: {1, [pair | kickers]}
  defp value(%{1 => ranks}), do: {0, ranks}
end
