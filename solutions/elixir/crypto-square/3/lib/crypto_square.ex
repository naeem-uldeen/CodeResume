defmodule CryptoSquare do

  def encode(""), do: ""
  def encode(message), do: build_square(normalize(message))

  defp normalize(message), do: normalize(message, "")
  defp normalize(<<>>, acc), do: acc
  defp normalize(<<char::utf8, rest::binary>>, acc) when char in ?a..?z, do:
    normalize(rest, acc <> <<char::utf8>>)
  defp normalize(<<char::utf8, rest::binary>>, acc) when char in ?A..?Z, do:
    normalize(rest, acc <> <<(char + 32)::utf8>>)
  defp normalize(<<char::utf8, rest::binary>>, acc) when char in ?0..?9, do:
    normalize(rest, acc <> <<char::utf8>>)
  defp normalize(<<_char::utf8, rest::binary>>, acc), do: normalize(rest, acc)

  defp build_square(""), do: ""
  defp build_square(normalized) do
    size = byte_size(normalized)
    num_cols = size |> :math.sqrt() |> Float.ceil() |> trunc()
    num_rows = (size / num_cols) |> Float.ceil() |> trunc()

    normalized
    |> pad(num_rows * num_cols - size)
    |> chunk_rows(num_cols)
    |> transpose()
    |> Enum.join(" ")
  end

  defp pad(binary, 0), do: binary
  defp pad(binary, remaining), do: pad(binary <> " ", remaining - 1)

  defp chunk_rows(binary, num_cols), do: chunk_rows(binary, num_cols, "", [])
  defp chunk_rows(<<>>, _num_cols, "", rows), do: Enum.reverse(rows)
  defp chunk_rows(binary, num_cols, row, rows) when byte_size(row) == num_cols, do:
    chunk_rows(binary, num_cols, "", [row | rows])
  defp chunk_rows(<<char::utf8, rest::binary>>, num_cols, row, rows), do:
    chunk_rows(rest, num_cols, row <> <<char::utf8>>, rows)

  defp transpose(rows), do: transpose(rows, [])
  defp transpose([<<>> | _], acc), do: Enum.reverse(acc)
  defp transpose(rows, acc) do
    {column, remaining_rows} = take_column(rows, "", [])
    transpose(remaining_rows, [column | acc])
  end

  defp take_column([], column, remaining_rows), do: {column, Enum.reverse(remaining_rows)}
  defp take_column([<<char::utf8, rest::binary>> | other_rows], column, remaining_rows), do:
    take_column(other_rows, column <> <<char::utf8>>, [rest | remaining_rows])

end
