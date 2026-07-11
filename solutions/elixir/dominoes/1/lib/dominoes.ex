defmodule Dominoes do
  @type domino :: {1..6, 1..6}

  @spec chain?(dominoes :: [domino]) :: boolean
  def chain?(ds) do
    ls = Enum.map(ds, fn {l, _} -> l end)
    rs = Enum.map(ds, fn {_, r} -> r end)
    # If the two collections of numbers don't match, no chain is possible
    if Enum.sort(ls) != Enum.sort(rs), do: false, else: chain(ds)
  end

  # self-matching pair
  defp chain([{n, n}]), do: true
  # A single domino that isn't a self-matching pair ({n, n}) can't form a chain.
  defp chain([_]), do: false
  # An empty list is considered chained.
  defp chain([]), do: true
  # Recursive case: {l, r} is the chain built so far.
  # Search rem for a domino that connects to r, fuse it in, and recurse on
  # the resulting shorter list (fused domino + rem minus the match).
  # find_value backtracks automatically: if a fused chain
  # dead ends (returns false), it tries the next candidate domino.
  defp chain([{l, r} | rem]) do
    Enum.find_value(rem, false, fn
      {^r, new_r} = d -> chain([{l, new_r} | List.delete(rem, d)])
      {new_r, ^r} = d -> chain([{l, new_r} | List.delete(rem, d)])
      _ -> false
    end)
  end

end
