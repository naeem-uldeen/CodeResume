defmodule LucasNumbers do

  def generate(n) when is_integer(n) and n >= 1, do:
    do_generate(n, 2, 1, [])

  def generate(_),
    do: raise(ArgumentError, "count must be specified as an integer >= 1")

  def lucas_numbers(),
    do:
      Stream.unfold({2, 1}, fn
        {current, next} ->
          {current, {next, _after_next = current + next}}
      end)

  defp do_generate(0, _current, _next, acc),
    do: Enum.reverse(acc)

  defp do_generate(remaining, current, next, acc), do:
    do_generate(remaining - 1, next, current + next, [current | acc])

end
