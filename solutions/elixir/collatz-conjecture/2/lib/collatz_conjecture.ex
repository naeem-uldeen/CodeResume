defmodule CollatzConjecture do

  def calc(number) when is_integer(number) and number >= 1,
    do: steps(number, 0)

  defp steps(1, steps), do: steps

  # recursive call is the very last operation (tail)
  # no further computation, so no stack frame needed after
  defp steps(number, steps),
    do: steps(if(rem(number, 2) == 0,
      do:   div(number, 2),
      else: 3 * number + 1),

      steps + 1)

end
