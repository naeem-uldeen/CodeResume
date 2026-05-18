defmodule RomanNumerals do

  values_and_symbols = [
    {1000, "M"},  {900, "CM"}, {500, "D"},  {400, "CD"},
    {100,  "C"},  {90,  "XC"}, {50,  "L"},  {40,  "XL"},
    {10,   "X"},  {9,   "IX"}, {5,   "V"},  {4,   "IV"},
    {1,    "I"}
  ]

  def numeral(n), do: numeral(n, "")

  defp numeral(0, acc), do: acc

  for {value, symbol} <- values_and_symbols do
    defp numeral(n, acc) when n >= unquote(value) do
      numeral(n - unquote(value), acc <> unquote(symbol))
    end
  end

end
