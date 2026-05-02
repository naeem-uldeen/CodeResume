defmodule Pangram do
  import Bitwise
  
  @mask (1 <<< 26) - 1

  def pangram?(phrase), do: pangram?(phrase, 0)

  defp pangram?(<<>>, seen), do: seen == @mask

  defp pangram?(<<letter, rest::binary>>, seen)
        when letter in ?a..?z do
    seen = seen ||| (1 <<< (letter - ?a))
    if seen == @mask,
      do: true,
      else: pangram?(rest, seen)
  end

  defp pangram?(<<letter, rest::binary>>, seen)
        when letter in ?A..?Z,
        do: pangram?(<<?a + letter - ?A, rest::binary>>, seen)

  defp pangram?(<<_::binary-size(1), rest::binary>>, seen),
    do: pangram?(rest, seen)
    
end
