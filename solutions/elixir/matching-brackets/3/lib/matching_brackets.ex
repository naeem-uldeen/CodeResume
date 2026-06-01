defmodule MatchingBrackets do

  @bracket_pairs [{?(, ?)}, {?[, ?]}, {?{, ?}}]

  def check_brackets(str), do: check(str, [])

  defp check(<<>>, stack), do: stack == []
  for {open, close} <- @bracket_pairs do
    defp check(<<unquote(open), rest::binary>>, stack), do: check(rest, [unquote(open) | stack])
    defp check(<<unquote(close), rest::binary>>, [unquote(open) | opened_brackets]),
      do: check(rest, opened_brackets)
    defp check(<<unquote(close), _::binary>>, _), do: false
  end
  defp check(<<_, rest::binary>>, stack), do: check(rest, stack)

end
