defmodule Scrabble do

  def score(word), do: score(String.downcase(word), 0)

  defp score("", acc), do: acc
  defp score(<<letter, rest::binary>>, acc),
    do: score(rest, acc + letter_score(letter))
  defp letter_score(?a), do: 1
  defp letter_score(?b), do: 3
  defp letter_score(?c), do: 3
  defp letter_score(?d), do: 2
  defp letter_score(?e), do: 1
  defp letter_score(?f), do: 4
  defp letter_score(?g), do: 2
  defp letter_score(?h), do: 4
  defp letter_score(?i), do: 1
  defp letter_score(?j), do: 8
  defp letter_score(?k), do: 5
  defp letter_score(?l), do: 1
  defp letter_score(?m), do: 3
  defp letter_score(?n), do: 1
  defp letter_score(?o), do: 1
  defp letter_score(?p), do: 3
  defp letter_score(?q), do: 10
  defp letter_score(?r), do: 1
  defp letter_score(?s), do: 1
  defp letter_score(?t), do: 1
  defp letter_score(?u), do: 1
  defp letter_score(?v), do: 4
  defp letter_score(?w), do: 4
  defp letter_score(?x), do: 8
  defp letter_score(?y), do: 4
  defp letter_score(?z), do: 10
  defp letter_score(_),  do: 0
  
end
