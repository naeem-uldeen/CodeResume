defmodule RotationalCipher do
  @moduledoc """
  Rotational cipher (Caesar cipher) that shifts alphabetic characters by a fixed amount.
  Non-alphabetic characters are passed through unchanged.
  """

  rotation_sets = [?a..?z, ?A..?Z]

  @doc "Rotates each alphabetic character in `text` forward by `shift` positions."
  @spec rotate(text :: String.t(), shift :: integer()) :: String.t()
  def rotate(text, shift), do: rotate(text, shift, <<>>)

  defp rotate(<<>>, _shift, acc), do: acc
  defp rotate(<<c, rest::binary>>, shift, acc),
    do: rotate(rest, shift, acc <> <<do_rotate(c, shift)>>)

  for set <- rotation_sets do
    first = Enum.at(set, 0)
    last  = Enum.at(set, -1)
    count = Enum.count(set)

    defp do_rotate(c, shift) when c >= unquote(first) and c <= unquote(last),
      do: rem(c - unquote(first) + shift, unquote(count)) + unquote(first)
  end

  defp do_rotate(c, _shift), do: c
  
end
