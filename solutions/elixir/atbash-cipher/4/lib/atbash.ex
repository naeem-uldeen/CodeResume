defmodule Atbash do

  def encode(plaintext),   do: group_by_five(do_encode(plaintext))
  def decode(cipher),      do: do_encode(cipher)

  defp do_encode(text),    do: do_encode(text, "")
  defp do_encode("", acc), do: acc
  defp do_encode(<<h, t::binary>>, acc) do
    case atbash_char(h) do
      nil     -> do_encode(t, acc)
      encoded -> do_encode(t, acc <> <<encoded>>)
    end
  end

  defp atbash_char(c) when c in ?a..?z, do: ?z - (c - ?a)
  defp atbash_char(c) when c in ?A..?Z, do: ?z - (c - ?A)
  defp atbash_char(c) when c in ?0..?9, do: c
  defp atbash_char(_c),                 do: nil

  defp group_by_five(encoded),       do: group_by_five(encoded, 0, "")
  defp group_by_five("", _, acc),    do: acc
  defp group_by_five(<<h, t::binary>>, 5, acc),     do: group_by_five(t, 1, acc <> " " <> <<h>>)
  defp group_by_five(<<h, t::binary>>, count, acc), do: group_by_five(t, count + 1, acc <> <<h>>)

end
