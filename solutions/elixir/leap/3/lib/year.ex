defmodule Year do

  defguard is_divisible(year, n) when rem(year, n) == 0

  def leap_year?(year),
    do:
      is_divisible(year, 4) and
        (not is_divisible(year, 100) or is_divisible(year, 400))
        
end
