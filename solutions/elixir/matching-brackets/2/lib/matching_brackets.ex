defmodule MatchingBrackets do

  @close_to_open %{?) => ?(, ?] => ?[, ?} => ?{}
  @open_brackets Map.values(@close_to_open)

  def check_brackets(str), do: check(str, [])

  defp check(<<>>, stack), do: stack == []
  defp check(<<open, rest::binary>>, stack) when open in @open_brackets, do: check(rest, [open | stack])
  defp check(<<close, rest::binary>>, [top | stack])
      when is_map_key(@close_to_open, close)
        and top == :erlang.map_get(close, @close_to_open), do: check(rest, stack)
  defp check(<<close, _::binary>>, _) when is_map_key(@close_to_open, close), do: false
  defp check(<<_, rest::binary>>, stack), do: check(rest, stack)

end
