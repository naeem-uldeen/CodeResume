defmodule Dominoes do
  require Integer

  @type domino :: {1..6, 1..6}
  @values 1..6
  @empty_cluster MapSet.new()

  @spec chain?(dominoes :: [domino]) :: boolean
  def chain?([]), do: true
  def chain?([{left_number, right_number} | _] = dominoes)
      when left_number in @values and right_number in @values,
      do: can_all_ends_be_connected(dominoes) and can_form_coherent_cluster(dominoes)

  # Condition 1: every number must appear an even number of times
  # across all dominoes, or some appearance is left without a partner
  # to pair off with, and the chain can never close.
  defp can_all_ends_be_connected(dominoes, edges_per_value \\ %{})
  defp can_all_ends_be_connected([{left_number, right_number} | dominoes], edges_per_value) do
    edges_per_value =
      edges_per_value
      |> Map.update(left_number, 1, &(&1 + 1))
      |> Map.update(right_number, 1, &(&1 + 1))

    can_all_ends_be_connected(dominoes, edges_per_value)
  end
  defp can_all_ends_be_connected([], edges_per_value),
    do: Enum.all?(Map.values(edges_per_value), &Integer.is_even/1)

  # Condition 2 (only reached once condition 1 holds): every number
  # must end up in the same cluster. A merge updates every member of
  # BOTH clusters being joined, not just the two numbers on the
  # current domino -- otherwise anyone already parked in either
  # cluster keeps a stale, smaller set once dominoes later in the
  # list connect it to something bigger.
  defp can_form_coherent_cluster(dominoes, clusters_per_value \\ %{})
  defp can_form_coherent_cluster([{left_number, right_number} | dominoes], clusters_per_value) do
    common_cluster =
      MapSet.union(
        Map.get(clusters_per_value, left_number) || @empty_cluster,
        Map.get(clusters_per_value, right_number) || @empty_cluster
      )
      |> MapSet.put(left_number)
      |> MapSet.put(right_number)

    clusters_per_value =
      Enum.reduce(common_cluster, clusters_per_value, fn value, acc ->
        Map.put(acc, value, common_cluster)
      end)

    can_form_coherent_cluster(dominoes, clusters_per_value)
  end
  # Once every merge is fully propagated, one coherent cluster means
  # every value maps to the exact same set -- so this no longer needs
  # the intersection trick, just a direct "is there only one cluster".
  defp can_form_coherent_cluster([], clusters_per_value),
    do: clusters_per_value |> Map.values() |> Enum.uniq() |> length() == 1
end
