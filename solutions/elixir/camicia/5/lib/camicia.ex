defmodule Camicia do
  @moduledoc """
  Simulates a Camicia card game.

  A jack, queen, king or ace obliges the opponent to pay 1, 2, 3 or 4 cards;
  every other card is a plain card worth 0. Whoever laid the last penalty card
  collects the center pile once the opponent has paid in full or has no card
  left to play, and then leads the next round.

  Everything that makes up a round (who is on the move, both decks and the
  center pile) is kept together as one value, the `round`. Each round starts by
  recording it in `previous_rounds`, so meeting the same round twice means the
  game is looping.
  """

  # Typespecs cannot list string literals, so the faces are only named in the doc.
  @typedoc ~s(The face of a card: "2" to "10", "J", "Q", "K" or "A".)
  @type card_face :: String.t()

  @typedoc "What a card is worth: 0 for a plain card, 1 to 4 for J, Q, K and A."
  @type card_value :: 0..4
  @type deck :: [card_value()]
  @type player :: :a | :b

  @typedoc """
  The player on the move, their deck, the opponent's deck and the center pile
  (last card played first). The pile is empty whenever a round starts.
  """
  @type round :: {player(), deck_player :: deck(), deck_opponent :: deck(), pile :: deck()}
  @type result :: {:finished | :loop, non_neg_integer(), non_neg_integer()}
  @no_cards []

  defstruct round: {:a, @no_cards, @no_cards, @no_cards},
            previous_rounds: MapSet.new(),
            penalty_due: 0,
            cards_played: 0,
            tricks_collected: 0

  @typedoc """
  The state of a game:

    * `round` - the round being played
    * `previous_rounds` - every round seen so far
    * `penalty_due` - how many cards the player on the move still owes (0 when
      nothing is due)
    * `cards_played` - cards laid on the center pile so far
    * `tricks_collected` - center piles collected so far
  """
  @type t :: %__MODULE__{
          round: round(),
          previous_rounds: MapSet.t(round()),
          penalty_due: card_value(),
          cards_played: non_neg_integer(),
          tricks_collected: non_neg_integer()
        }

  @doc """
  Simulates a game between two players.

  Each player's deck is a list of cards, listed in the order they will be
  played. Returns:

    * `{:finished, cards_played, tricks_collected}` when one player runs out
      of cards
    * `{:loop, cards_played, tricks_collected}` when a round repeats, so the
      game would go on forever

  ## Examples

      iex> Camicia.simulate(["2"], ["3"])
      {:finished, 2, 1}

      iex> Camicia.simulate(["J", "2", "3"], ["4", "J", "5"])
      {:loop, 8, 3}
  """
  @spec simulate([card_face()], [card_face()]) :: result()
  def simulate(player_a_cards, player_b_cards),
    do:
      %__MODULE__{round: {:a, deck(player_a_cards), deck(player_b_cards), @no_cards}}
      |> begin_round()
      |> play_until_game_over()

  defp deck(cards),
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

  defp advance(%__MODULE__{round: {_player, @no_cards, _opponent_deck, _pile}} = game),
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
        | round: {player, active_deck, opponent_deck ++ Enum.reverse(pile), @no_cards},
          penalty_due: 0,
          tricks_collected: game.tricks_collected + 1
      }
      |> switch_players()
      |> begin_round()

  defp begin_round(%__MODULE__{round: {_player, _active_deck, @no_cards, @no_cards}} = game),
    do: {:finished, game.cards_played, game.tricks_collected}
  defp begin_round(%__MODULE__{round: round, previous_rounds: previous_rounds} = game) do
    case MapSet.put(previous_rounds, round) do
      ^previous_rounds -> {:loop, game.cards_played, game.tricks_collected}
      round_added -> %{game | previous_rounds: round_added}
    end
  end
end
