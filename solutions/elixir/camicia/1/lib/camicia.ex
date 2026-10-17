defmodule Camicia do

  @type card :: String.t()
  @type penalty :: 0..4
  @type player :: :a | :b
  @type position :: {player(), [penalty()], [penalty()]}
  @type result :: {:finished | :loop, non_neg_integer(), non_neg_integer()}

  defstruct active_player: :a,
            active_deck: [],
            opponent_deck: [],
            center_pile: [],
            penalty_due: 0,
            cards_played: 0,
            tricks_collected: 0,
            seen_positions: %{}

  @type t :: %__MODULE__{
          active_player: player(),
          active_deck: [penalty()],
          opponent_deck: [penalty()],
          center_pile: [penalty()],
          penalty_due: penalty(),
          cards_played: non_neg_integer(),
          tricks_collected: non_neg_integer(),
          seen_positions: %{optional(position()) => true}
        }

  @spec simulate([card()], [card()]) :: result()
  def simulate(player_a_cards, player_b_cards),
    do:
      %__MODULE__{
        active_player: :a,
        active_deck: to_penalties(player_a_cards),
        opponent_deck: to_penalties(player_b_cards)
      }
      |> begin_round()

  defp to_penalties(cards), do: to_penalties(cards, [])
  defp to_penalties([], penalties_so_far), do: Enum.reverse(penalties_so_far)
  defp to_penalties([card | remaining_cards], penalties_so_far),
    do: to_penalties(remaining_cards, [penalty_of(card) | penalties_so_far])

  defp penalty_of("A"), do: 4
  defp penalty_of("K"), do: 3
  defp penalty_of("Q"), do: 2
  defp penalty_of("J"), do: 1
  defp penalty_of(_plain_card), do: 0

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

  defp begin_round(%__MODULE__{} = game), do: game |> remember_position() |> play_next_card()

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

  # The active player cannot play: whoever demanded the last card wins the trick.
  defp play_next_card(%__MODULE__{active_deck: []} = game), do: game |> collect_trick() |> begin_round()
  defp play_next_card(%__MODULE__{active_deck: [0 | _rest]} = game), do: game |> play_active_card() |> settle_plain_card()
  # A penalty card hands the turn to the opponent, who now owes cards.
  defp play_next_card(%__MODULE__{active_deck: [penalty | _rest]} = game) when penalty in 1..4,
    do: game |> play_active_card() |> pass_turn() |> demand_penalty(penalty) |> play_next_card()

  # No penalty pending: the turn simply passes.
  defp settle_plain_card(%__MODULE__{penalty_due: 0} = game), do: game |> pass_turn() |> play_next_card()
  # The last card of the penalty was just paid: the trick is over.
  defp settle_plain_card(%__MODULE__{penalty_due: 1} = game), do: game |> collect_trick() |> begin_round()
  # One more card of the penalty paid, more still to pay.
  defp settle_plain_card(%__MODULE__{penalty_due: penalty_due} = game) when penalty_due > 1,
    do: play_next_card(%{game | penalty_due: penalty_due - 1})

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
             penalty_due: 0,
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
