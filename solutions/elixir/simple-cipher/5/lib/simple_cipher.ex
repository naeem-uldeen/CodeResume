defmodule SimpleCipher do

  @alphabet ?a..?z
  @first Enum.at(@alphabet, 0)
  @count Enum.count(@alphabet)

  def encode(plaintext, key), do: shifted(plaintext, key, &+/2)
  def decode(encoded, key),   do: shifted(encoded, key, &-/2)

  defp shifted(text, key, shift_fn), do: shifted(text, key, key, <<>>, shift_fn)
  defp shifted(<<>>, _key, _key_cpy, acc, _shift_fn), do: acc
  defp shifted(text, <<>>, key_cpy, acc, shift_fn), do: shifted(text, key_cpy, key_cpy, acc, shift_fn)
  defp shifted(<<c, rest::binary>>, <<k, key_rest::binary>>, key_cpy, acc, shift_fn) when c in @alphabet,
    do: shifted(rest, key_rest, key_cpy, acc <> <<rem(shift_fn.(c - @first, k - @first) + @count, @count) + @first>>, shift_fn)
  defp shifted(<<c, rest::binary>>, <<k, key_rest::binary>>, key_cpy, acc, shift_fn),
    do: shifted(rest, key_rest, key_cpy, acc <> <<c>>, shift_fn)

  def generate_key(length), do: for(_ <- 1..length//1, into: <<>>, do: <<Enum.random(@alphabet)>>)

end
