defmodule PalindromeProducts do

  def generate(max_factor, min_factor \\ 1)
  def generate(max_factor, min_factor) when min_factor > max_factor,
    do: raise(ArgumentError, "min_factor must be less than or equal to max_factor")
  def generate(max_factor, min_factor) do
    for f1 <- min_factor..max_factor,
        f2 <- f1..max_factor,
        product = f1 * f2,
        palindrome?(product),
        reduce: %{} do
      acc -> Map.update(acc, product, [[f1, f2]], &[[f1, f2] | &1])
    end
  end

  defp palindrome?(n), do: n == reverse_digits(n, 0)
  defp reverse_digits(0, acc), do: acc
  defp reverse_digits(n, acc), do: reverse_digits(div(n, 10), acc * 10 + rem(n, 10))
  
end

