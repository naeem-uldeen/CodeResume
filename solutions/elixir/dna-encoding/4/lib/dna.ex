defmodule DNA do

  @nucleotides [{?\s, 0b0000}, {?A, 0b0001}, {?C, 0b0010}, {?G, 0b0100}, {?T, 0b1000}]

  for {code_point, value} <- @nucleotides do
    def encode_nucleotide(unquote(code_point)), do: unquote(value)
    def decode_nucleotide(unquote(value)), do: unquote(code_point)
  end

  def encode(strand), do: do_encode(strand, <<>>)

  defp do_encode([], acc), do: acc

  for {code_point, value} <- @nucleotides do
    defp do_encode([unquote(code_point) | rest], acc),
      do: do_encode(rest, <<acc::bitstring, unquote(value)::4>>)
  end

  def decode(binary), do: do_decode(binary, [])

  defp do_decode(<<>>, acc), do: Enum.reverse(acc)

  for {code_point, value} <- @nucleotides do
    defp do_decode(<<unquote(value)::4, rest::bitstring>>, acc),
      do: do_decode(rest, [unquote(code_point) | acc])
  end
  
end
