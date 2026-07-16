defmodule CryptoSquare do
  def encode(msg) when is_binary(msg),
    do:
      with(
        {normalized, count} when is_binary(normalized) and is_integer(count) <- normalize(msg, 0, <<>>),
        cols = max(ceil(:math.sqrt(count)), 1),
        last_row_size = rem(count, cols),
        rows = if(last_row_size == 0, do: div(count, cols), else: div(count, cols) + 1),
        filling_spaces = if(last_row_size > 0, do: String.duplicate(" ", cols - last_row_size), else: ""),
        do: if(count > 0, do: encode(normalized <> filling_spaces, 0, 0, cols, rows, <<>>), else: "")
      )

  defp normalize(<<lower_case, msg::binary>>, count, output) when lower_case in ?a..?z,
    do: normalize(msg, count + 1, output <> <<lower_case>>)
  defp normalize(<<digit, msg::binary>>, count, output) when digit in ?0..?9,
    do: normalize(msg, count + 1, output <> <<digit>>)
  defp normalize(<<upper_case, msg::binary>>, count, output) when upper_case in ?A..?Z,
    do: normalize(msg, count + 1, output <> <<?a + upper_case - ?A>>)
  defp normalize(<<_drop, msg::binary>>, count, output), do: normalize(msg, count, output)
  defp normalize(<<>>, count, output), do: {output, count}

  defp encode(normalized, col, row, cols, rows, encoded)
  defp encode(_normalized, col, rows, cols, rows, encoded) when col == cols - 1, do: encoded
  defp encode(normalized, col, rows, cols, rows, encoded),
    do: encode(normalized, col + 1, 0, cols, rows, encoded <> " ")
  defp encode(normalized, col, row, cols, rows, encoded) when row < rows and col < cols,
    do: encode(normalized, col, row + 1, cols, rows, encoded <> <<:binary.at(normalized, row * cols + col)>>)
end
