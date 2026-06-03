defmodule PerfectNumbers do

  @spec classify(number :: integer) :: {:ok, atom} | {:error, String.t()}
  def classify(n) when n < 1, do: {:error, "Classification is only possible for natural numbers."}
  def classify(1), do: {:ok, :deficient}
  def classify(n), do: classify(aliquot_sum(n), n)

  defp classify(sum, n) when sum > n, do: {:ok, :abundant}
  defp classify(sum, n) when sum < n, do: {:ok, :deficient}
  defp classify(_sum, _n),            do: {:ok, :perfect}

  defp aliquot_sum(n), do: aliquot_sum(n, 2, 1)
  defp aliquot_sum(n, d, acc) when d * d > n,                     do: acc
  defp aliquot_sum(n, d, acc) when rem(n, d) == 0 and d * d == n, do: aliquot_sum(n, d + 1, acc + d)
  defp aliquot_sum(n, d, acc) when rem(n, d) == 0,                do: aliquot_sum(n, d + 1, acc + d + div(n, d))
  defp aliquot_sum(n, d, acc),                                    do: aliquot_sum(n, d + 1, acc)
  
end
