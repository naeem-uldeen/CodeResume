defmodule RotationalCipher do

  def rotate(<<>>, _shift), do: ""
  def rotate(<<c, rest::binary>>, shift),
    do: <<do_rotate(c, shift)>> <> rotate(rest, shift)
  
  defp do_rotate(c, shift) when c in ?a..?z, do: rem(c - ?a + shift, 26) + ?a
  defp do_rotate(c, shift) when c in ?A..?Z, do: rem(c - ?A + shift, 26) + ?A
  defp do_rotate(c, _shift), do: c
  
end
