defmodule MatchingBrackets do

  @pairs %{?) => ?(, ?] => ?[, ?} => ?{}

  def check_brackets(str), do: check(str, [])

  defp check(<<>>, stack), do: stack == []
  defp check(<<c, rest::binary>>, stack) when c in ~c"([{", do: check(rest, [c | stack])
  defp check(<<c, rest::binary>>, [top | stk]) when is_map_key(@pairs, c) and top == :erlang.map_get(c, @pairs), do: check(rest, stk)
  defp check(<<c, _::binary>>, _) when is_map_key(@pairs, c), do: false
  defp check(<<_, rest::binary>>, stack), do: check(rest, stack)

end
