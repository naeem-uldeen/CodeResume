defmodule Pangram do
  import Bitwise, only: [<<<: 2, |||: 2]

  @all_letters_set (1 <<< 26) - 1

  def pangram?(phrase), do: pangram?(phrase, 0)

  defp pangram?(<<>>, _), do: false

  defp pangram?(<<letter, rest::binary>>, seen) when
    letter in ?a..?z do
      seen = seen ||| (1 <<< (letter - ?a))
      seen == @all_letters_set or pangram?(rest, seen)
  end

  defp pangram?(<<upper_letter, rest::binary>>, seen) when
    upper_letter in ?A..?Z do
      seen = seen ||| (1 <<< (upper_letter - ?A))
      seen == @all_letters_set or pangram?(rest, seen)
  end

  defp pangram?(<<_::binary-size(1), rest::binary>>, seen),
    do: pangram?(rest, seen)

end
