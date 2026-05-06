defmodule Luhn do

  def valid?(input) when is_binary(input),
    do:
      with(
        chars    = Enum.reject(String.to_charlist(input), & &1 == ?\s),
        true     <- Enum.all?(chars, & &1 in ?0..?9),
        digits   = Enum.map(chars, & &1 - ?0),
        true     <- length(digits) >= 2,

        weighted_digits =
          Enum.map(Enum.with_index(Enum.reverse(digits), 1), fn
            {n, odd_index}   when rem(odd_index, 2) == 1 -> n
            {n, _even_index} when n > 4 -> 2 * n - 9
            {n, _even_index} -> 2 * n
          end),
        sum      = Enum.sum(weighted_digits),
        do: rem(sum, 10) == 0
      )

end
