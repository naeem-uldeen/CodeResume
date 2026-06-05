defmodule PerfectNumbers do

  @spec classify(number :: integer) :: {:ok, atom} | {:error, String.t()}
  def classify(n) when n > 0 do
    {:ok,
     case aliquot_sum(n) do
       sum when sum > n -> :abundant
       sum when sum < n -> :deficient
       _                -> :perfect
     end}
  end
  def classify(_n), do: {:error, "Classification is only possible for natural numbers."}

  defp aliquot_sum(n, d \\ 2, acc \\ 1)
  defp aliquot_sum(1, _d, _acc),                   do: 0
  defp aliquot_sum(n, d, acc) when d * d > n,      do: acc
  defp aliquot_sum(n, d, acc) when d * d == n,     do: acc + d
  defp aliquot_sum(n, d, acc) when rem(n, d) == 0, do: aliquot_sum(n, d + 1, acc + d + div(n, d))
  defp aliquot_sum(n, d, acc),                     do: aliquot_sum(n, d + 1, acc)
  
end
