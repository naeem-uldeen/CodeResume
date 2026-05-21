defmodule BottleSong do

  @separator "\n\n"

  def recite(start, count), do: do_recite(start, count, [])

  defp do_recite(_start, 0, acc),
    do: Enum.join(Enum.reverse(acc), @separator)
  defp do_recite(start, count, acc),
    do: do_recite(start - 1, count - 1, [verse(start) | acc])

  defp number_word(0),  do: "no"
  defp number_word(1),  do: "one"
  defp number_word(2),  do: "two"
  defp number_word(3),  do: "three"
  defp number_word(4),  do: "four"
  defp number_word(5),  do: "five"
  defp number_word(6),  do: "six"
  defp number_word(7),  do: "seven"
  defp number_word(8),  do: "eight"
  defp number_word(9),  do: "nine"
  defp number_word(10), do: "ten"

  defp green_bottles(1), do: "one green bottle"
  defp green_bottles(n), do: "#{number_word(n)} green bottles"

  defp caps(phrase), do: String.capitalize(phrase)

  defp verse(n, d \\ 1),
    do: """
    #{caps(n |> green_bottles())} hanging on the wall,
    #{caps(n |> green_bottles())} hanging on the wall,
    And if #{d |> green_bottles()} should accidentally fall,
    There'll be #{n - d |> green_bottles()} hanging on the wall.\
    """

end
