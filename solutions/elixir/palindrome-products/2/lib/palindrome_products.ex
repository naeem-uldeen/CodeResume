defmodule PalindromeProducts do

  def generate(max_factor, min_factor \\ 1)
  def generate(max_factor, min_factor) when min_factor > max_factor,
    do: raise(ArgumentError, "min_factor must be less than or equal to max_factor")
  def generate(max_factor, min_factor),
    do: palindromes(max_factor, min_factor)|> Enum.reverse()|> Enum.group_by(fn [f1, f2] -> f1 * f2 end)

  defp palindromes(max_factor, min_factor), do:
    for f1 <- min_factor..max_factor, f2 <- f1..max_factor, palindrome?(f1 * f2), do: [f1, f2]
    
  defp palindrome?(n), do: Integer.digits(n) == Enum.reverse(Integer.digits(n))

end
