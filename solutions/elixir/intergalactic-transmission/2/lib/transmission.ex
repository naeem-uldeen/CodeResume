defmodule Transmission do
  @spec get_transmit_sequence(binary()) :: binary()
  def get_transmit_sequence(message), do: encode(message, <<>>)

  @spec decode_message(binary()) :: {:ok, binary()} | {:error, String.t()}
  def decode_message(received_data), do: decode(received_data, <<>>)

  defp encode(<<>>, acc), do: acc
  defp encode(<<data::7, rest::bitstring>>, acc),
    do: encode(rest, <<acc::bitstring, data::7, parity(data)::1>>)
  defp encode(tail, acc), do: encode(<<tail::bitstring, 0::size(7 - bit_size(tail))>>, acc)

  defp decode(<<>>, acc), do: {:ok, strip_padding(acc)}
  defp decode(<<data::7, received::1, rest::binary>>, acc) do
    case parity(data) do
      ^received -> decode(rest, <<acc::bitstring, data::7>>)
      _ -> {:error, "wrong parity"}
    end
  end

  defp strip_padding(bits) do
    size = div(bit_size(bits), 8)
    <<message::binary-size(size), _padding::bitstring>> = bits
    message
  end

  defp parity(data), do: parity(data, 0)
  defp parity(0, acc), do: acc
  defp parity(data, acc), do: parity(div(data, 2), Bitwise.bxor(acc, rem(data, 2)))
end
