defmodule PerfectNumbers do

  @spec classify(number :: integer) :: {:ok, atom} | {:error, String.t()}
  def classify(n) when n < 1, do: {:error, "Classification is only possible for natural numbers."}
  def classify(1), do: {:ok, :deficient}
  def classify(n) when n > 1, do: (aliquot_sum = Enum.sum(Enum.filter(1..div(n, 2), &(rem(n, &1) == 0))); classify(aliquot_sum, n))

  defp classify(aq, n) when aq > n, do: {:ok, :abundant}
  defp classify(aq, n) when aq < n, do: {:ok, :deficient}
  defp classify(_aq, _n),           do: {:ok, :perfect}

end
