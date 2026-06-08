defmodule FlattenArray do

  def flatten(list), do: flat(list, [])

  defp flat([], acc), do: Enum.reverse(acc) # Base case: all elements processed, reverse the accumulator
  defp flat([nil | tl], acc), do: flat(tl, acc) # Skip nil values
  # Handle nested list: [hd | inner_tl] becomes [hd, inner_tl | tl]
  # This progressively flattens from the inside out
  defp flat([[hd | inner_tl] | tl], acc), do: flat([hd | [inner_tl | tl]], acc)
  defp flat([[] | tl], acc), do: flat(tl, acc) # Handle empty nested list
  defp flat([hd | tl], acc), do: flat(tl, [hd | acc]) # Regular element: add to accumulator (prepend for O(1))

end
