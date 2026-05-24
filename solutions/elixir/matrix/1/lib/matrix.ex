defmodule Matrix do

  defstruct rows: [], columns: [], dimensions: {}

  def from_string(str), do: build_matrix(parse_rows(String.split(str, "\n"), []))

  def to_string(%__MODULE__{rows: rows}), do: join_rows(rows)

  def rows(%__MODULE__{rows: rows}), do: rows

  def columns(%__MODULE__{columns: columns}), do: columns

  def row(%__MODULE__{rows: rows, dimensions: {n_rows, _}}, row_number)
      when row_number in 1..n_rows//1,
      do: Enum.at(rows, row_number - 1)
  def row(%__MODULE__{}, row_number)
      when row_number >= 1, do: nil

  def column(%__MODULE__{columns: columns, dimensions: {_, n_cols}}, col_number)
      when col_number in 1..n_cols//1,
      do: Enum.at(columns, col_number - 1)
  def column(%__MODULE__{}, col_number)
      when col_number >= 1, do: nil

  defp build_matrix(rows) do
    num_cols = length(hd(rows))
    %__MODULE__{
      rows: rows,
      columns: build_cols(rows, 1, num_cols, []),
      dimensions: {length(rows), num_cols}
    }
  end

  defp parse_rows([], parsed_rows), do: Enum.reverse(parsed_rows)
  defp parse_rows([line | rest], parsed_rows),
    do: parse_rows(rest, [Enum.map(String.split(line), &String.to_integer/1) | parsed_rows])

  defp build_cols(_rows, col_num, max_col, collected_cols)
      when col_num > max_col, do: Enum.reverse(collected_cols)
  defp build_cols(rows, col_num, max_col, collected_cols),
    do: build_cols(rows, col_num + 1, max_col, [extract_col(rows, col_num, []) | collected_cols])

  defp extract_col([], _col_num, col_entries), do: Enum.reverse(col_entries)
  defp extract_col([row | rest], col_num, col_entries),
    do: extract_col(rest, col_num, [Enum.at(row, col_num - 1) | col_entries])

  defp join_rows(rows),
    do:
      Enum.map_join(
        rows,
        "\n",
        &Enum.map_join(&1, " ", fn n -> Integer.to_string(n) end)
      )
end
