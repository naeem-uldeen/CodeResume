defmodule Strain do

  @spec keep(list :: list(any), predicate :: (any -> boolean)) :: list(any)
  def keep(list, predicate), do: keep(list, predicate, [])

  defp keep([], _predicate, acc), do: reverse(acc, [])
  defp keep([head | tail], predicate, acc),
    do: keep(tail, predicate, if(predicate.(head), do: [head | acc], else: acc))

  defp reverse([], acc), do: acc
  defp reverse([head | tail], acc), do: reverse(tail, [head | acc])

  @spec discard(list :: list(any), predicate :: (any -> boolean)) :: list(any)
  def discard(list, predicate), do: keep(list, &(not predicate.(&1)))

end
