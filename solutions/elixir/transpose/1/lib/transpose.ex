defmodule Transpose do

  def transpose(""), do: ""
  def transpose(str), do: str|> split_rows([])|> transpose_rows()

  defp split_rows(<<>>, acc), do: Enum.reverse(acc)
  defp split_rows(bin, acc) do
    {row, rem} = extract_row(bin, <<>>)
    split_rows(rem, [row | acc])
  end

  defp extract_row(<<"\n", rem::binary>>, row), do: {row, rem}
  defp extract_row(<<c::binary-size(1), rem::binary>>, row), do: extract_row(rem, row <> c)
  defp extract_row(<<>>, row), do: {row, <<>>}

  defp transpose_rows(rows) do
    case extract_column(rows, [], [], false) do
      {[], _rem, false} -> ""
      {col, rem, true} -> col_str = build_string(Enum.reverse(col), <<>>)
        case transpose_rows(rem) do
          "" -> col_str
          rem_str -> col_str <> "\n" <> rem_str
        end
    end
  end

  defp extract_column([<<c::binary-size(1), rem_bin::binary>> | rows], col, rem, _has), do:
    extract_column(rows, [c | col], [rem_bin | rem], true)
  defp extract_column([<<>> | rows], col, rem, has) do
    if Enum.any?(rows, fn r -> r != <<>> end) do
      extract_column(rows, [" " | col], [<<>> | rem], true)
    else
      {col, Enum.reverse(rem), has}
    end
  end
  defp extract_column([], col, rem, has), do: {col, Enum.reverse(rem), has}

  defp build_string([], acc), do: acc
  defp build_string([c | rem], acc), do: build_string(rem, acc <> c)

end
