defmodule Luhn do

  def valid?(input) when is_binary(input),
    do:
      with(                                  # is this item a space?
        chars = Enum.reject(String.to_charlist(input), &(&1 == ?\s)),
        true <- Enum.all?(chars, &(&1 in ?0..?9)),
        digits = Enum.map(chars, &(&1 - ?0)),
        true <- length(digits) >= 2,
        do:
          digits
          |> Enum.reverse()
          |> Enum.with_index(1)
          |> Enum.map(fn
            {n, i} when rem(i, 2) == 1 -> n
            # 4 is the last digit where doubling stays within a single digit
            {n, _} when n > 4          -> 2 * n - 9
            {n, _}                     -> 2 * n
          end)
          |> Enum.sum()
          |> rem(10) == 0
      )

end
