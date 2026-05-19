defmodule BottleSong do

  @number_words %{
    10 => "ten", 9 => "nine", 8 => "eight", 7 => "seven",
    6 => "six",  5 => "five", 4 => "four",  3 => "three",
    2 => "two",  1 => "one",  0 => "no"
  }
  @wall "hanging on the wall"
  @fall "And if one green bottle should accidentally fall,"
  @separator "\n\n"

  def recite(start, count), do: do_recite(start, count, [])

  defp do_recite(_start, 0, acc),
    do: Enum.join(Enum.reverse(acc), @separator)
  defp do_recite(start, count, acc),
    do: do_recite(start - 1, count - 1, [verse(start) | acc])

  defp bottles(1), do: "one green bottle"
  defp bottles(0), do: "no green bottles"
  defp bottles(n), do: "#{@number_words[n]} green bottles"

  defp verse(n) do
    current   = String.capitalize(bottles(n))
    remaining = bottles(n - 1)
    "#{current} #{@wall},\n#{current} #{@wall},\n#{@fall}\nThere'll be #{remaining} #{@wall}."
  end

end
