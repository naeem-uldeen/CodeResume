defmodule Transpose do
  @moduledoc """
  Transposes text: rows become columns.

  Short rows are padded with spaces up to the length of the longest
  row still to come. Once no later row has more content, the rest of
  the shorter rows are dropped instead of padded, so output lines
  never end in trailing whitespace.
  """

  @doc """
  Transposes `text`, a block of `\n`-separated rows, into its
  transposed form.
  """
  @spec transpose(String.t()) :: String.t()
  def transpose(""), do: ""
  def transpose(text) do
    text
    |> split_rows([])
    |> transpose_rows()
  end

  defp split_rows(<<>>, rows), do: Enum.reverse(rows)
  defp split_rows(text, rows) do
    {row, rest} = extract_row(text, <<>>)
    split_rows(rest, [row | rows])
  end

  defp extract_row(<<"\n", rest::binary>>, row), do: {row, rest}
  defp extract_row(<<c::binary-size(1), rest::binary>>, row), do: extract_row(rest, row <> c)
  defp extract_row(<<>>, row), do: {row, <<>>}

  defp transpose_rows(rows) do
    rows
    |> extract_column([], [])
    |> build_row()
  end

  defp build_row({[], _remaining_rows}), do: ""
  defp build_row({column, remaining_rows}) do
    column
    |> Enum.reverse()
    |> build_string(<<>>)
    |> join_rows(transpose_rows(remaining_rows))
  end

  defp join_rows(row, ""), do: row
  defp join_rows(row, rest), do: row <> "\n" <> rest

  defp extract_column([<<c::binary-size(1), rest::binary>> | rows], column, remaining_rows),
    do: extract_column(rows, [c | column], [rest | remaining_rows])
  defp extract_column([<<>> | rows], column, remaining_rows),
    do: pad_or_stop(rows_status(rows), rows, column, remaining_rows)
  defp extract_column([], column, remaining_rows), do: {column, Enum.reverse(remaining_rows)}

  defp pad_or_stop(:has_content, rows, column, remaining_rows),
    do: extract_column(rows, [" " | column], [<<>> | remaining_rows])
  defp pad_or_stop(:exhausted, _rows, column, remaining_rows),
    do: {column, Enum.reverse(remaining_rows)}

  defp rows_status([]), do: :exhausted
  defp rows_status([<<>> | rows]), do: rows_status(rows)
  defp rows_status([_row | _rows]), do: :has_content

  defp build_string([], acc), do: acc
  defp build_string([c | rest], acc), do: build_string(rest, acc <> c)
  
end

