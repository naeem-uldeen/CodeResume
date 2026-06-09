defmodule RunLengthEncoder do

  def encode(original) when is_binary(original),
    do: encoded(original)

  defp encoded(string, acc \\ <<>>)
  defp encoded(<<c, c, _::binary>> = string_with_repeated_c, acc) do
    {runlength, rest} = runlength_and_rest(string_with_repeated_c, c, 0)
    encoded(rest, acc <> Integer.to_string(runlength) <> <<c>>)
  end
  defp encoded(<<c, rest::binary>>, acc),
    do: encoded(rest, acc <> <<c>>)
  defp encoded(<<>>, acc), do: acc

  defp runlength_and_rest(<<c, rest::binary>>, c, n),
    do: runlength_and_rest(rest, c, n + 1)
  defp runlength_and_rest(rest, _c, n), do: {n, rest}

  def decode(encoded) when is_binary(encoded),
    do: decoded(encoded)

  defp decoded(string, acc \\ <<>>)
  defp decoded(<<c, rest::binary>> = string, acc) do
    case Integer.parse(string) do
      :error ->
        decoded(rest, acc <> <<c>>)
      {runlength, <<char, rest2::binary>>} ->
        decoded(rest2, acc <> String.duplicate(<<char>>, runlength))
    end
  end
  defp decoded(<<>>, acc), do: acc
  
end
