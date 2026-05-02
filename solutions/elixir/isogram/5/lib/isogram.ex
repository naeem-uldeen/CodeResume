defmodule Isogram do

  def isogram?(phrase),
    do: isogram?(phrase, MapSet.new())

  defp isogram?(<<>>, _seen), do: true

  defp isogram?(<<letter, phrase::binary>>, seen)
        when letter in ?a..?z do
    if letter in seen,
      do: false,
      else: isogram?(phrase, MapSet.put(seen, letter))
  end

  defp isogram?(<<letter, phrase::binary>>, seen)
        when letter in ?A..?Z,
        do: isogram?(<<?a + letter - ?A, phrase::binary>>, seen)

  defp isogram?(<<_::binary-size(1), phrase::binary>>, seen),
    do: isogram?(phrase, seen)

end
