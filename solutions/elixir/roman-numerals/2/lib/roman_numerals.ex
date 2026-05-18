defmodule RomanNumerals do

  @table [
    {1000, "M"},  {900, "CM"}, {500, "D"},  {400, "CD"},
    {100,  "C"},  {90,  "XC"}, {50,  "L"},  {40,  "XL"},
    {10,   "X"},  {9,   "IX"}, {5,   "V"},  {4,   "IV"},
    {1,    "I"}
  ]

  for {value, symbol} <- @table do
    def numeral(n) when n >= unquote(value) do
      unquote(symbol) <> numeral(n - unquote(value))
    end
  end

  def numeral(0), do: ""
  
end
