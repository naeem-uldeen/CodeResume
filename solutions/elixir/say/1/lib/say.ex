defmodule Say do

  def in_english(n) when n < 0 or n > 999_999_999_999, do: {:error, "number is out of range"}
  def in_english(n), do: {:ok, say(n)}

  defp say(0), do: "zero"
  defp say(n), do: Enum.join(say(n, []), " ")

  defp say(0, acc), do: Enum.reverse(acc)
  defp say(n, acc) when n >= 1_000_000_000, do: say(rem(n, 1_000_000_000), [below_thousand(div(n, 1_000_000_000)) <> " billion" | acc])
  defp say(n, acc) when n >= 1_000_000, do: say(rem(n, 1_000_000), [below_thousand(div(n, 1_000_000)) <> " million" | acc])
  defp say(n, acc) when n >= 1_000, do: say(rem(n, 1_000), [below_thousand(div(n, 1_000)) <> " thousand" | acc])
  defp say(n, acc), do: Enum.reverse([below_thousand(n) | acc])

  defp below_thousand(n) when n < 100, do: below_hundred(n)
  defp below_thousand(n) when rem(n, 100) == 0, do: ones(div(n, 100)) <> " hundred"
  defp below_thousand(n), do: ones(div(n, 100)) <> " hundred " <> below_hundred(rem(n, 100))

  defp below_hundred(n) when n < 20, do: ones(n)
  defp below_hundred(n) when rem(n, 10) == 0, do: tens(div(n, 10))
  defp below_hundred(n), do: tens(div(n, 10)) <> "-" <> ones(rem(n, 10))

  defp ones(0), do: "zero"
  defp ones(1), do: "one"
  defp ones(2), do: "two"
  defp ones(3), do: "three"
  defp ones(4), do: "four"
  defp ones(5), do: "five"
  defp ones(6), do: "six"
  defp ones(7), do: "seven"
  defp ones(8), do: "eight"
  defp ones(9), do: "nine"
  defp ones(10), do: "ten"
  defp ones(11), do: "eleven"
  defp ones(12), do: "twelve"
  defp ones(13), do: "thirteen"
  defp ones(14), do: "fourteen"
  defp ones(15), do: "fifteen"
  defp ones(16), do: "sixteen"
  defp ones(17), do: "seventeen"
  defp ones(18), do: "eighteen"
  defp ones(19), do: "nineteen"

  defp tens(2), do: "twenty"
  defp tens(3), do: "thirty"
  defp tens(4), do: "forty"
  defp tens(5), do: "fifty"
  defp tens(6), do: "sixty"
  defp tens(7), do: "seventy"
  defp tens(8), do: "eighty"
  defp tens(9), do: "ninety"
end
