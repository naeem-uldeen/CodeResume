defmodule Squares do
  @doc """
  Calculates the sum of squares of the first `n` natural numbers.
  """
  @spec sum_of_squares(non_neg_integer()) :: integer()
  def sum_of_squares(n), do: div(n * (n + 1) * (2 * n + 1), 6)

  @doc """
  Calculates the square of the sum of the first `n` natural numbers.
  Uses the formula for triangular numbers: `n(n+1)/2`.
  """
  @spec square_of_sum(non_neg_integer()) :: integer()
  def square_of_sum(n), do: (_triangular_number = div(n * (n + 1), 2)) ** 2

  @doc """
  Calculates the difference between the square of the sum and the sum of squares
  of the first `n` natural numbers.
  """
  @spec difference(non_neg_integer()) :: integer()
  def difference(n), do: square_of_sum(n) - sum_of_squares(n)
end

