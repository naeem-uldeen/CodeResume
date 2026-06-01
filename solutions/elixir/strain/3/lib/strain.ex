defmodule Strain do

  def keep(elements, keep?) when is_list(elements) and is_function(keep?, 1),
    do: filter(elements, keep?)

  def discard(elements, discard?) when is_list(elements) and is_function(discard?, 1),
    do: filter(elements, &not discard?.(&1))

  defp filter(elements, predicate, filtered \\ [])
  defp filter([element | elements], predicate, filtered),
    do: filter(elements, predicate,
      if(predicate.(element), do: [element | filtered], else: filtered)
    )
  defp filter([], _, filtered), do: reverse(filtered)

  defp reverse(elements, reversed \\ [])
  defp reverse([element | elements], reversed),
    do: reverse(elements, [element | reversed])
  defp reverse([], reversed), do: reversed

end
