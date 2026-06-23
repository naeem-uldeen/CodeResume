defmodule Poker do

  @rank_values %{
    "2" => 2, "3" => 3, "4" => 4, "5" => 5, "6" => 6, "7" => 7, "8" => 8,
    "9" => 9, "10" => 10, "J" => 11, "Q" => 12, "K" => 13, "A" => 14
  }

  @spec best_hand([[String.t()]]) :: [[String.t()]]
  def best_hand(hands) do
    hands
    |> Enum.group_by(&score/1)
    |> Enum.max_by(fn {score, _hands} -> score end)
    |> elem(1)
  end

  defp score(cards) do
    {ranks, suits} = parse(cards)

    ranks
    |> Enum.frequencies()
    |> Enum.map(fn {rank, count} -> {count, rank} end)
    |> Enum.sort(:desc)
    |> classify(ranks, suits)
  end

  defp classify([{4, quad}, {1, kicker}], _ranks, _suits), do: {7, [quad, kicker]}
  defp classify([{3, triple}, {2, pair}], _ranks, _suits), do: {6, [triple, pair]}
  defp classify([{3, triple}, {1, k1}, {1, k2}], _ranks, _suits), do: {3, [triple, k1, k2]}
  defp classify([{2, p1}, {2, p2}, {1, kicker}], _ranks, _suits), do: {2, [p1, p2, kicker]}
  defp classify([{2, pair}, {1, k1}, {1, k2}, {1, k3}], _ranks, _suits), do: {1, [pair, k1, k2, k3]}

  defp classify([{1, _}, {1, _}, {1, _}, {1, _}, {1, _}], ranks, suits) do
    high = ranks |> Enum.sort() |> straight_high()
    category(same_suit?(suits), high, ranks)
  end

  defp category(true, high, _ranks) when not is_nil(high), do: {8, [high]}
  defp category(true, nil, ranks), do: {5, Enum.sort(ranks, :desc)}
  defp category(false, high, _ranks) when not is_nil(high), do: {4, [high]}
  defp category(false, nil, ranks), do: {0, Enum.sort(ranks, :desc)}

  defp straight_high([2, 3, 4, 5, 14]), do: 5
  defp straight_high([a, b, c, d, e]) when b == a + 1 and c == a + 2 and d == a + 3 and e == a + 4, do: e
  defp straight_high(_sorted), do: nil

  defp same_suit?(suits), do: suits |> Enum.uniq() |> length() == 1

  defp parse(cards), do: cards |> Enum.map(&parse_card/1) |> Enum.unzip()

  defp parse_card(card) do
    {rank, suit} = String.split_at(card, -1)
    {Map.fetch!(@rank_values, rank), suit}
  end
  
end
