defmodule CollatzConjecture do

  def calc(1), do: 0

  def calc(number) when is_integer(number) and number > 1 do
    number = if rem(number, 2) == 0,
      do:   div(number, 2),
      else: 3 * number + 1

    1 + calc(number)
  end

end
