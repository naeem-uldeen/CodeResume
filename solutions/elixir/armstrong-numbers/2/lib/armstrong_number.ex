defmodule ArmstrongNumber do

   def valid?(number) when is_integer(number),
    do: with(
      digits = Integer.digits(number),
      number_of_digits = Enum.count(digits),
      armstrong_sum = Enum.reduce(digits, 0, &(&2 + &1**number_of_digits)),

      do: number == armstrong_sum)

end
