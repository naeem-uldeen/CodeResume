defmodule Isogram do

  @downcase_offset ?a - ?A

  def isogram?(sentence),
    do: isogram?(sentence, MapSet.new())

  defp isogram?(<<>>, _seen), do: true

  defp isogram?(<<letter::utf8, remaining::binary>>, seen) when
    letter >= ?a and letter <= ?z do
    if letter in seen,
      do: false,
      else: isogram?(remaining, MapSet.put(seen, letter))
  end

  defp isogram?(<<letter::utf8, remaining::binary>>, seen) when
    letter >= ?A and letter <= ?Z do
    lower = letter + @downcase_offset
    if lower in seen,
      do: false,
      else: isogram?(remaining, MapSet.put(seen, lower))
  end

  defp isogram?(<<_::utf8, remaining::binary>>, seen),
    do: isogram?(remaining, seen)

end
