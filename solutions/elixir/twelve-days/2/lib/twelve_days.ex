defmodule TwelveDays do

  def sing, do: verses(1, 12)

  def verses(start, stop) when start in 1..12 and stop in 1..12 and start <= stop,
    do: Enum.map_join(start..stop, "\n", &verse/1)

  def verse(n) when n in 1..12,
    do: "On the #{nth(n)} day of Christmas my true love gave to me: #{gifts(n)}."

  defp nth(1),  do: "first"
  defp nth(2),  do: "second"
  defp nth(3),  do: "third"
  defp nth(4),  do: "fourth"
  defp nth(5),  do: "fifth"
  defp nth(6),  do: "sixth"
  defp nth(7),  do: "seventh"
  defp nth(8),  do: "eighth"
  defp nth(9),  do: "ninth"
  defp nth(10), do: "tenth"
  defp nth(11), do: "eleventh"
  defp nth(12), do: "twelfth"

  defp gifts(12), do: "twelve Drummers Drumming, " <> gifts(11)
  defp gifts(11), do: "eleven Pipers Piping, "     <> gifts(10)
  defp gifts(10), do: "ten Lords-a-Leaping, "      <> gifts(9)
  defp gifts(9),  do: "nine Ladies Dancing, "      <> gifts(8)
  defp gifts(8),  do: "eight Maids-a-Milking, "    <> gifts(7)
  defp gifts(7),  do: "seven Swans-a-Swimming, "   <> gifts(6)
  defp gifts(6),  do: "six Geese-a-Laying, "       <> gifts(5)
  defp gifts(5),  do: "five Gold Rings, "          <> gifts(4)
  defp gifts(4),  do: "four Calling Birds, "       <> gifts(3)
  defp gifts(3),  do: "three French Hens, "        <> gifts(2)
  defp gifts(2),  do: "two Turtle Doves, and "     <> gifts(1)
  defp gifts(1),  do: "a Partridge in a Pear Tree"

end
