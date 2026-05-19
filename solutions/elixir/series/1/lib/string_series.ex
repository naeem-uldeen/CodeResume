defmodule StringSeries do

  def slices(_digits, span) when span <= 0, do: []
  def slices(digits, span) when span > byte_size(digits), do: []
  def slices(digits, span), do: slide_window(digits, span, [])

  defp slide_window(digits, span, acc) when byte_size(digits) >= span do
    window = binary_part(digits, 0, span)
    <<_head, tail::binary>> = digits
    slide_window(tail, span, [window | acc])
  end
  defp slide_window(_digits, _span, acc), do: Enum.reverse(acc)
  
end
