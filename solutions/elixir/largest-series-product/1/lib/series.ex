defmodule Series do

  def largest_product(_, span) when span < 0,
    do: raise(ArgumentError, "span must not be negative")
  def largest_product(_, 0), do: 1
  def largest_product(digits, span) when span > byte_size(digits),
    do: raise(ArgumentError, "span must be smaller than string length")
  def largest_product(digits, span) do
    scan_chunks(digits, span, 0)
  end
  defp scan_chunks(digits = <<_head, tail::binary>>, span, current_max)
       when byte_size(tail) >= span - 1 do
    product = product(digits, span, 1)
    new_max = max(current_max, product)
    scan_chunks(tail, span, new_max)
  end
  defp scan_chunks(_digits, _span, current_max), do: current_max
  defp product(_digits, 0, acc), do: acc
  defp product(<<head, tail::binary>>, n, acc) when head in ?0..?9 and n > 0,
    do: product(tail, n - 1, acc * (head - ?0))
  defp product(_, _, _), do: raise(ArgumentError, "digits must only contain digits")
  
end
