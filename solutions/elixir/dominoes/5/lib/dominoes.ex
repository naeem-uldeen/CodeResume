defmodule Dominoes do
  @type domino :: {1..6, 1..6}

  @spec chain?(dominoes :: [domino]) :: boolean
  def chain?([]), do: true
  def chain?(dominoes), do: even_degrees?(dominoes) and connected?(dominoes)

  # ------------------------------------------------------------------
  # Condition 1 (cheap -- checked first): every number touched by a
  # domino must be touched an even number of times. Every appearance
  # on one side needs a matching appearance on another domino's side,
  # or the chain can never close. A self-matching domino {number,
  # number} touches its number twice by itself.
  # ------------------------------------------------------------------

  defp even_degrees?(dominoes) do
    dominoes
    |> Enum.reduce(%{}, &record_occurrence/2)
    |> Map.values()
    |> Enum.all?(&even_number?/1)
  end

  defp record_occurrence({number, number}, occurrence_counts), do:
    add_occurrences(occurrence_counts, number, 2)
  defp record_occurrence({left_number, right_number}, occurrence_counts) do
    occurrence_counts
    |> add_occurrences(left_number, 1)
    |> add_occurrences(right_number, 1)
  end

  defp add_occurrences(occurrence_counts, number, amount), do:
    Map.update(occurrence_counts, number, amount, &(&1 + amount))

  defp even_number?(number), do: rem(number, 2) == 0

  # ------------------------------------------------------------------
  # Condition 2 (only checked once condition 1 holds): every number
  # touched by a domino must be reachable from every other one -- the
  # dominoes must form a single connected set, not several separate
  # groups.
  # ------------------------------------------------------------------

  defp connected?(dominoes) do
    touched_numbers = numbers_in(dominoes)
    [starting_number | _] = touched_numbers
    reachable_numbers = explore(dominoes, MapSet.new([starting_number]))

    Enum.all?(touched_numbers, &MapSet.member?(reachable_numbers, &1))
  end

  defp numbers_in(dominoes) do
    dominoes
    |> Enum.flat_map(fn {left_number, right_number} -> [left_number, right_number] end)
    |> Enum.uniq()
  end

  # Grow the reached set by following every domino that has one side
  # already reached, repeating until a full pass adds nothing new
  # (a fixed point) -- at most as many passes as there are numbers.
  defp explore(dominoes, reached_numbers) do
    grown_numbers = Enum.reduce(dominoes, reached_numbers, &follow_domino/2)
    settle(dominoes, reached_numbers, grown_numbers)
  end

  defp settle(_dominoes, reached_numbers, grown_numbers) when reached_numbers == grown_numbers, do:
    reached_numbers
  defp settle(dominoes, _reached_numbers, grown_numbers), do:
    explore(dominoes, grown_numbers)

  defp follow_domino({left_number, right_number}, reached_numbers) do
    place(
      left_number,
      right_number,
      reached_numbers,
      MapSet.member?(reached_numbers, left_number),
      MapSet.member?(reached_numbers, right_number)
    )
  end

  defp place(_left_number, right_number, reached_numbers, true, _right_number_reached?), do:
    MapSet.put(reached_numbers, right_number)
  defp place(left_number, _right_number, reached_numbers, _left_number_reached?, true), do:
    MapSet.put(reached_numbers, left_number)
  defp place(_left_number, _right_number, reached_numbers, false, false), do:
    reached_numbers

end
