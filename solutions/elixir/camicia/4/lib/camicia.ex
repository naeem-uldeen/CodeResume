defmodule Camicia do
  @type card :: String.t()
  @type penalty :: 0..4
  @type player :: :a | :b
  @type round :: {player(), [penalty()], [penalty()], [penalty()]}
  @type result :: {:finished | :loop, non_neg_integer(), non_neg_integer()}
  @empty_pile []

  defstruct round: {:a, [], [], @empty_pile},
            previous_rounds: %{},
            penalty_due: 0,
            cards_played: 0,
            tricks_collected: 0

  @type t :: %__MODULE__{
          round: round(),
          previous_rounds: %{optional(round()) => non_neg_integer()},
          penalty_due: penalty(),
          cards_played: non_neg_integer(),
          tricks_collected: non_neg_integer()
        }

  @spec simulate([card()], [card()]) :: result()
  def simulate(player_a_cards, player_b_cards),
    do:
      %__MODULE__{
        round: {:a, to_penalties(player_a_cards), to_penalties(player_b_cards), @empty_pile}
      }
      |> begin_round()
      |> play_until_game_over()

  defp to_penalties(cards),
    do:
      Enum.map(cards, fn
        "A" -> 4
        "K" -> 3
        "Q" -> 2
        "J" -> 1
        _plain_card -> 0
      end)

  defp play_until_game_over({_status, _cards_played, _tricks_collected} = result), do: result
  defp play_until_game_over(%__MODULE__{} = game), do: game |> advance() |> play_until_game_over()

  defp advance(%__MODULE__{round: {_player, [] = _cannot_play, _opponent_deck, _pile}} = game),
    do: collect_trick(game)
  defp advance(%__MODULE__{round: {_player, [0 | _rest], _opponent_deck, _pile}} = game),
    do: game |> play_card() |> settle_plain_card()
  defp advance(%__MODULE__{round: {_player, [penalty | _rest], _opponent_deck, _pile}} = game)
       when penalty in 1..4,
       do: game |> play_card() |> switch_players() |> demand_penalty(penalty)

  defp play_card(%__MODULE__{round: {player, [card | rest_of_deck], opponent_deck, pile}} = game),
    do: %{
      game
      | round: {player, rest_of_deck, opponent_deck, [card | pile]},
        cards_played: game.cards_played + 1
    }

  defp switch_players(%__MODULE__{round: {:a, deck_a, deck_b, pile}} = game),
    do: %{game | round: {:b, deck_b, deck_a, pile}}
  defp switch_players(%__MODULE__{round: {:b, deck_b, deck_a, pile}} = game),
    do: %{game | round: {:a, deck_a, deck_b, pile}}

  defp demand_penalty(%__MODULE__{} = game, penalty), do: %{game | penalty_due: penalty}

  defp settle_plain_card(%__MODULE__{penalty_due: 0} = game), do: switch_players(game)
  defp settle_plain_card(%__MODULE__{penalty_due: 1} = game), do: collect_trick(game)
  defp settle_plain_card(%__MODULE__{penalty_due: penalty_due} = game) when penalty_due > 1,
    do: %{game | penalty_due: penalty_due - 1}

  defp collect_trick(%__MODULE__{round: {player, active_deck, opponent_deck, pile}} = game),
    do:
      %{
        game
        | round: {player, active_deck, opponent_deck ++ Enum.reverse(pile), @empty_pile},
          penalty_due: 0,
          tricks_collected: game.tricks_collected + 1
      }
      |> switch_players()
      |> begin_round()

  defp begin_round(
         %__MODULE__{round: {_player, _active_deck, [] = _opponent_cannot_play, @empty_pile}} =
           game
       ),
       do: {:finished, game.cards_played, game.tricks_collected}

  defp begin_round(%__MODULE__{round: round, previous_rounds: previous_rounds} = game),
    do:
      if(is_map_key(previous_rounds, round),
        do: {:loop, game.cards_played, game.tricks_collected},
        else: %{game | previous_rounds: Map.put(previous_rounds, round, game.tricks_collected)}
      )
end
