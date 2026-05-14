defmodule Atbash do

  def encode(plaintext),   do: group_by_five(do_encode(plaintext))
  def decode(cipher),      do: do_encode(cipher)

  defp do_encode(text),    do: do_encode(text, [])
  defp do_encode("", acc), do: acc |> Enum.reverse() |> IO.iodata_to_binary()
  defp do_encode(<<h::utf8, t::binary>>, acc) do
    case atbash_char(h) do
      nil     -> do_encode(t, acc)
      encoded -> do_encode(t, [encoded | acc])
    end
  end

  defp atbash_char(char) when char in ?a..?z, do: ?z - (char - ?a)
  defp atbash_char(char) when char in ?A..?Z, do: ?z - (char + 32 - ?a)
  defp atbash_char(char) when char in ?0..?9, do: char
  defp atbash_char(_char),                    do: nil

  defp group_by_five(encoded),    do: group_by_five(encoded, 0, [])
  defp group_by_five("", _, acc), do: acc |> Enum.reverse() |> IO.iodata_to_binary()
  defp group_by_five(<<h::utf8, t::binary>>, 5, acc),     do: group_by_five(t, 1, [h, ?\s | acc])
  defp group_by_five(<<h::utf8, t::binary>>, count, acc), do: group_by_five(t, count + 1, [h | acc])

end
