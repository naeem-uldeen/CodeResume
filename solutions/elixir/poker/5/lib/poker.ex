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
  def best_hand(hands) when is_list(hands),
    do:
      with(
        values_and_hands = Enum.group_by(hands, &comparable_value/1),
        [{_max_value, best_hands} | _] = Enum.sort(values_and_hands, :desc),
        do: best_hands
      )

  defp comparable_value(hand) do
    case in_hand(hand) do
      %{:flush => _suit, 1 => [r5, r4, r3, r2, r1]}
      when r1 == r2 - 1 and r2 == r3 - 1 and r3 == r4 - 1 and r4 == r5 - 1 ->
        {8, [r5]}
      %{:flush => _suit, 1 => [@rank_ace, 5, 4, 3, 2]} -> {8, [5]}
      %{4 => [quad], 1 => [kicker]} ->{7, [quad, kicker]}
      %{3 => [triple], 2 => [pair]} -> {6, [triple, pair]}
      %{:flush => _suit, 1 => ranks} -> {5, ranks}
      %{1 => [r5, r4, r3, r2, r1]}
      when r1 == r2 - 1 and r2 == r3 - 1 and r3 == r4 - 1 and r4 == r5 - 1 ->
        {4, [r5]}
      %{1 => [@rank_ace, 5, 4, 3, 2]} -> {4, [5]}
      %{3 => [triple], 1 => kickers} -> {3, [triple | kickers]}
      %{2 => [p1, p2], 1 => [kicker]} -> {2, [p1, p2, kicker]}
      %{2 => [pair], 1 => kickers} -> {1, [pair | kickers]}
      %{1 => ranks} -> {0, ranks}
    end
  end

  defp in_hand(hand) do
    cards = Enum.map(hand, &card/1)
    cards
    |> descending_ranks_by_cardinality()
    |> may_add_flush_suit(cards)
  end

  defp card(card_string), do: Map.fetch!(@cards_by_string, card_string)

  defp descending_ranks_by_cardinality(cards),
    do:
      with(
        ranks = Enum.map(cards, &rank/1),
        count_per_rank = Enum.frequencies(ranks),
        ranks_by_count = Enum.group_by(count_per_rank, fn {_rank, count} -> count end, fn {rank, _count} -> rank end),
        do: Map.new(ranks_by_count, fn {count, ranks} -> {count, Enum.sort(ranks, :desc)} end)
      )

  defp rank({rank, _suit}), do: rank

  defp may_add_flush_suit(properties, [{_, s}, {_, s}, {_, s}, {_, s}, {_, s}]), do: Map.put(properties, :flush, s)
  defp may_add_flush_suit(properties, _cards), do: properties
end
