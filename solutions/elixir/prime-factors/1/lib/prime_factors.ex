defmodule PrimeFactors do

  def factors_for(number) when is_integer(number) and number < 2, do: []
  def factors_for(number) when is_integer(number), do: factors_for(number, 2, [])

  defp factors_for(1, _candidate, factors), do: Enum.reverse(factors)
  defp factors_for(number, candidate, factors) when candidate * candidate > number, do: Enum.reverse([number | factors])
  defp factors_for(number, candidate, factors) when rem(number, candidate) == 0, do: factors_for(div(number, candidate), candidate, [candidate | factors])

  defp factors_for(number, 2, factors), do: factors_for(number, 3, factors)
  defp factors_for(number, 3, factors), do: factors_for(number, 5, factors)
  defp factors_for(number, candidate, factors) when rem(candidate, 6) == 5, do: factors_for(number, candidate + 2, factors)
  defp factors_for(number, candidate, factors), do: factors_for(number, candidate + 4, factors)
  
end
