defmodule StringSeries do

  def slices(_digits, span) when span <= 0, do: []
  def slices(digits, span), do: sliding_windows(digits, span, [])

  defp sliding_windows(<<_head, tail::binary>> = digits, span, slices)
      when byte_size(digits) >= span,
      do: sliding_windows(tail, span, [binary_part(digits, 0, span) | slices])
  defp sliding_windows(_digits, _span, slices), do: Enum.reverse(slices)

end
