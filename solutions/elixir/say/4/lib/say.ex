defmodule Say do

  def in_english(n) when n < 0 or n > 999_999_999_999,
    do: {:error, "number is out of range"}
  def in_english(n), do: {:ok, say(n)}

  defp say(0), do: "zero"
  defp say(n), do: say(n, [])

  for {divisor, unit} <- [
    {1_000_000_000, "billion"},
    {1_000_000, "million"},
    {1_000, "thousand"}] do
    defp say(n, acc) when n >= unquote(divisor),
      do: say(rem(n, unquote(divisor)),
        [english_number(div(n, unquote(divisor))) <> unquote(" " <> unit) | acc])
  end

  defp say(0, acc), do: Enum.join(Enum.reverse(acc), " ")
  defp say(n, acc), do: say(0, [english_number(n) | acc])

  defp english_number(0),  do: "zero"
  defp english_number(1),  do: "one"
  defp english_number(2),  do: "two"
  defp english_number(3),  do: "three"
  defp english_number(4),  do: "four"
  defp english_number(5),  do: "five"
  defp english_number(6),  do: "six"
  defp english_number(7),  do: "seven"
  defp english_number(8),  do: "eight"
  defp english_number(9),  do: "nine"
  defp english_number(10), do: "ten"
  defp english_number(11), do: "eleven"
  defp english_number(12), do: "twelve"
  defp english_number(13), do: "thirteen"
  defp english_number(14), do: "fourteen"
  defp english_number(15), do: "fifteen"
  defp english_number(16), do: "sixteen"
  defp english_number(17), do: "seventeen"
  defp english_number(18), do: "eighteen"
  defp english_number(19), do: "nineteen"
  defp english_number(20), do: "twenty"
  defp english_number(30), do: "thirty"
  defp english_number(40), do: "forty"
  defp english_number(50), do: "fifty"
  defp english_number(60), do: "sixty"
  defp english_number(70), do: "seventy"
  defp english_number(80), do: "eighty"
  defp english_number(90), do: "ninety"
  defp english_number(n) when n < 100,
    do: english_number(n - rem(n, 10)) <> "-" <> english_number(rem(n, 10))
  defp english_number(n) when rem(n, 100) == 0,
    do: english_number(div(n, 100)) <> " hundred"
  defp english_number(n),
    do: english_number(div(n, 100)) <> " hundred " <> english_number(rem(n, 100))

end
