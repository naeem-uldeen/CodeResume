defmodule Atbash do

  def encode(plaintext), do: group_by_five(do_encode(plaintext))
  def decode(cipher),    do: do_encode(cipher)

  defp do_encode(""), do: ""
  defp do_encode(<<h::utf8, t::binary>>) do
    case atbash_char(h) do
      nil -> do_encode(t)
      encoded -> <<encoded::utf8>> <> do_encode(t)
    end
  end

  defp atbash_char(char) when char in ?a..?z, do: ?z - (char - ?a)
  defp atbash_char(char) when char in ?A..?Z do
    lower_char = char + 32
    ?z - (lower_char - ?a)
  end
  defp atbash_char(char) when char in ?0..?9, do: char
  defp atbash_char(_char), do: nil


  defp group_by_five(encoded), do: group_by_five(encoded, 0, "")
  # base case, stop recursion
  defp group_by_five("", _, acc), do: acc
  # when count hits 5, inserts a space and reset count to 1
  defp group_by_five(<<h::utf8, t::binary>>, 5, acc) do
    group_by_five(t, 1, acc <> " " <> <<h::utf8>>)
  end
  # normal case, just increment and add the character
  defp group_by_five(<<h::utf8, t::binary>>, count, acc) do
    group_by_five(t, count + 1, acc <> <<h::utf8>>)
  end

end
