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

  defp palindrome?(n), do: digits_match?(n, leading_place_value(n))

  defp leading_place_value(n, place_value \\ 1)
  defp leading_place_value(n, place_value) when n < place_value * 10, do: place_value
  defp leading_place_value(n, place_value), do: leading_place_value(n, place_value * 10)

  defp digits_match?(_remaining_digits, place_value) when place_value <= 1, do: true
  defp digits_match?(remaining_digits, place_value) do
    leading_digit = div(remaining_digits, place_value)
    trailing_digit = rem(remaining_digits, 10)
    leading_digit == trailing_digit and
      digits_match?(remaining_digits
        |> rem(place_value)
        |> div(10), div(place_value, 100)
      )
  end

end
