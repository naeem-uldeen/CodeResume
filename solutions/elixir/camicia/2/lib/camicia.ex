defmodule Camicia do
  @type card :: String.t()
  @type penalty :: 0..4
  @type player :: :a | :b
  @type penalty_due :: :none | 1..4 | :paid
  @type position :: {player(), [penalty()], [penalty()]}
  @type result :: {:finished | :loop, non_neg_integer(), non_neg_integer()}

  defstruct active_player: :a,
            active_deck: [],
            opponent_deck: [],
            center_pile: [],
            penalty_due: :none,
            cards_played: 0,
            tricks_collected: 0,
            seen_positions: %{}

  @type t :: %__MODULE__{
          active_player: player(),
          active_deck: [penalty()],
          opponent_deck: [penalty()],
          center_pile: [penalty()],
          penalty_due: penalty_due(),
          cards_played: non_neg_integer(),
          tricks_collected: non_neg_integer(),
          seen_positions: %{optional(position()) => true}
        }

  @spec simulate([card()], [card()]) :: result()
  def simulate(player_a_cards, player_b_cards),
    do:
      %__MODULE__{
        active_deck: to_penalties(player_a_cards),
        opponent_deck: to_penalties(player_b_cards)
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

  defp advance(%__MODULE__{} = game), do: advance(game, next_move(game))
  defp advance(game, :trick_complete), do: game |> collect_trick() |> begin_round()
  defp advance(game, 0), do: game |> play_active_card() |> settle_plain_card()
  defp advance(game, penalty) when penalty in 1..4,
    do: game |> play_active_card() |> pass_turn() |> demand_penalty(penalty)

  defp next_move(%__MODULE__{penalty_due: :paid}), do: :trick_complete
  defp next_move(%__MODULE__{active_deck: []}), do: :trick_complete
  defp next_move(%__MODULE__{active_deck: [penalty | _rest]}), do: penalty

  defp begin_round(%__MODULE__{opponent_deck: []} = game), do: report(game, :finished)
  defp begin_round(
         %__MODULE__{
           active_player: player,
           active_deck: active_deck,
           opponent_deck: opponent_deck,
           seen_positions: seen_positions
         } = game
       )
       when is_map_key(seen_positions, {player, active_deck, opponent_deck}),
       do: report(game, :loop)
  defp begin_round(%__MODULE__{} = game), do: remember_position(game)

  defp remember_position(
         %__MODULE__{
           active_player: player,
           active_deck: active_deck,
           opponent_deck: opponent_deck,
           seen_positions: seen_positions
         } = game
       ),
       do: %{
         game
         | seen_positions: Map.put(seen_positions, {player, active_deck, opponent_deck}, true)
       }

  defp play_active_card(
         %__MODULE__{
           active_deck: [card | rest_of_deck],
           center_pile: center_pile,
           cards_played: cards_played
         } = game
       ),
       do: %{
         game
         | active_deck: rest_of_deck,
           center_pile: [card | center_pile],
           cards_played: cards_played + 1
       }

  defp settle_plain_card(%__MODULE__{penalty_due: :none} = game), do: pass_turn(game)
  defp settle_plain_card(%__MODULE__{penalty_due: 1} = game), do: %{game | penalty_due: :paid}
  defp settle_plain_card(%__MODULE__{penalty_due: penalty_due} = game) when penalty_due in 2..4,
    do: %{game | penalty_due: penalty_due - 1}

  defp demand_penalty(%__MODULE__{} = game, penalty), do: %{game | penalty_due: penalty}

  defp collect_trick(
         %__MODULE__{
           opponent_deck: opponent_deck,
           center_pile: center_pile,
           tricks_collected: tricks_collected
         } = game
       ),
       do:
         %{
           game
           | opponent_deck: opponent_deck ++ Enum.reverse(center_pile),
             center_pile: [],
             penalty_due: :none,
             tricks_collected: tricks_collected + 1
         }
         |> pass_turn()

  defp pass_turn(
         %__MODULE__{
           active_player: player,
           active_deck: active_deck,
           opponent_deck: opponent_deck
         } = game
       ),
       do: %{
         game
         | active_player: other_player(player),
           active_deck: opponent_deck,
           opponent_deck: active_deck
       }

  defp other_player(:a), do: :b
  defp other_player(:b), do: :a

  defp report(
         %__MODULE__{cards_played: cards_played, tricks_collected: tricks_collected},
         status
       ),
       do: {status, cards_played, tricks_collected}
end
