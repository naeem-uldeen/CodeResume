defmodule SimpleCipher do
  @moduledoc """
  Vigenère cipher for encoding and decoding text with a repeating key.
  Non-alphabetic characters are passed through unchanged.
  """

  @alphabet ?a..?z
  @first Enum.at(@alphabet, 0)
  @count Enum.count(@alphabet)

  @spec encode(String.t(), String.t()) :: String.t()
  @doc "Encodes `plaintext` using the Vigenère cipher with `key`."
  def encode(plaintext, key), do: shifted(plaintext, key, &+/2)

  @spec decode(String.t(), String.t()) :: String.t()
  @doc "Decodes `encoded` text that was encoded with `key`."
  def decode(encoded, key), do: shifted(encoded, key, &-/2)

  @spec generate_key(non_neg_integer()) :: String.t()
  @doc "Generates a random lowercase alphabetic key of the given `length`."
  def generate_key(length), do: generate_key(length, <<>>)

  defp shifted(text, key, shift_fn), do: shifted(text, key, key, <<>>, shift_fn)
  defp shifted(<<>>, _key, _key_cpy, acc, _shift_fn), do: acc
  defp shifted(text, <<>>, key_cpy, acc, shift_fn), do: shifted(text, key_cpy, key_cpy, acc, shift_fn)
  defp shifted(<<c, rest::binary>>, <<k, key_rest::binary>>, key_cpy, acc, shift_fn),
    do: shifted(rest, key_rest, key_cpy, acc <> <<do_shift(c, k, shift_fn)>>, shift_fn)

  defp do_shift(c, k, shift_fn) when c in @alphabet,
    do: rem(shift_fn.(c - @first, k - @first) + @count, @count) + @first
  defp do_shift(c, _k, _shift_fn), do: c

  defp generate_key(0, acc), do: acc
  defp generate_key(n, acc), do: generate_key(n - 1, acc <> <<Enum.random(@alphabet)>>)
  
end
