defmodule TwelveDays do

  @ordinals %{
    1 => "first", 2 => "second", 3 => "third", 4 => "fourth",
    5 => "fifth", 6 => "sixth", 7 => "seventh", 8 => "eighth",
    9 => "ninth", 10 => "tenth", 11 => "eleventh", 12 => "twelfth"
  }
  @gifts %{
    1  => "a Partridge in a Pear Tree",
    2  => "two Turtle Doves",
    3  => "three French Hens",
    4  => "four Calling Birds",
    5  => "five Gold Rings",
    6  => "six Geese-a-Laying",
    7  => "seven Swans-a-Swimming",
    8  => "eight Maids-a-Milking",
    9  => "nine Ladies Dancing",
    10 => "ten Lords-a-Leaping",
    11 => "eleven Pipers Piping",
    12 => "twelve Drummers Drumming"
  }
  @refrain "day of Christmas my true love gave to me: "

  def verse(n), do: "On the #{@ordinals[n]} #{@refrain}#{gifts(n)}."

  defp gifts(1), do: "a Partridge in a Pear Tree"
  defp gifts(2), do: "two Turtle Doves, and a Partridge in a Pear Tree"
  defp gifts(n), do: "#{@gifts[n]}, #{gifts(n - 1)}"

  def verses(start, stop), do: do_verses(start, stop, [])

  defp do_verses(start, stop, acc) when start > stop,
    do: Enum.join(Enum.reverse(acc), "\n")
  defp do_verses(start, stop, acc),
    do: do_verses(start + 1, stop, [verse(start) | acc])

  def sing, do: verses(1, 12)

end
