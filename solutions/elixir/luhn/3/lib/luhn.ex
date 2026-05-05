defmodule Luhn do

  def valid?(input) do
    digits =
      input
      |> String.replace(" ", "")
      |> String.graphemes()
      |> Enum.map(&Integer.parse/1)
    # Integer.parse tries to read a number from a string
    # and always returns one of two shapes:
    # Integer.parse("7")  # {7, ""}  — succeeded, number is 7, nothing left over
    # Integer.parse("a")  # :error   — failed, "a" is not a number
    all_digits? = Enum.all?(digits, &match?({_, ""}, &1))

    all_digits? and length(digits) >= 2 and
      digits
      |> Enum.map(&elem(&1, 0))
      |> Enum.reverse()
      |> Enum.with_index(1)
      |> Enum.map(fn
        {n, i} when rem(i, 2) == 1 -> n
        {n, _} when n > 4 -> 2 * n - 9
        {n, _} -> 2 * n
      end)
      |> Enum.sum()
      |> rem(10) == 0
  end

end