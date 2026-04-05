defmodule ArmstrongNumber do

  def valid?(number) do
   digits = Integer.digits number
   len = length digits
   armstrong_sum =
     Enum.reduce(digits, 0, fn digit, sum -> digit**len + sum end)

   number == armstrong_sum
 end

end
