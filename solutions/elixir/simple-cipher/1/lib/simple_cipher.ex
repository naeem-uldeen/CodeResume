defmodule SimpleCipher do

  def encode(plaintext, key),  do: cipher(plaintext, key, key, 1)
  def decode(ciphertext, key), do: cipher(ciphertext, key, key, -1)

  defp cipher(<<>>, _key, _orig, _dir), do: ""
  defp cipher(text, <<>>, orig, dir),   do: cipher(text, orig, orig, dir)
  defp cipher(<<c, rest::binary>>, <<k, key_rest::binary>>, orig, dir),
    do: <<shift(c, k, dir)>> <> cipher(rest, key_rest, orig, dir)

  defp shift(c, k, dir) when c in ?a..?z, do: rem(c - ?a + dir * (k - ?a) + 26, 26) + ?a
  defp shift(c, _k, _dir), do: c

  def generate_key(0), do: ""
  def generate_key(n), do: <<Enum.random(?a..?z)>> <> generate_key(n - 1)
  
end
