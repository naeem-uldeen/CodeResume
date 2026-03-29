defmodule CollatzConjecture do

  def calc(number) when is_integer(number) and number >= 1,
    do: steps(number, 0)

  defguardp is_even(n) when rem(n, 2) == 0

  defp steps(1, steps), do: steps

  defp steps(n, steps) when is_even(n),
    do: steps(div(n, 2), steps + 1)

  defp steps(n, steps),
    do: steps(3 * n + 1, steps + 1)

end
