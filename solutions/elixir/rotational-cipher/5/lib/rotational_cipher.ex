defmodule RotationalCipher do

  rotation_sets = [?a..?z, ?A..?Z]

  def rotate(text, shift), do: rotate(text, shift, <<>>)

  defp rotate(<<>>, _shift, acc), do: acc
  for first.._last//_ = set <- rotation_sets, count = Enum.count(set) do
    defp rotate(<<c, rest::binary>>, shift, acc) when c in unquote(Macro.escape(set)),
      do: rotate(rest, shift, acc <> <<rem(c - unquote(first) + shift, unquote(count)) + unquote(first)>>)
  end
  defp rotate(<<c, rest::binary>>, shift, acc), do: rotate(rest, shift, acc <> <<c>>)
  
end
