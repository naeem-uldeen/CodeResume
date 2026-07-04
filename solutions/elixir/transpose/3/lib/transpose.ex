defmodule Transpose do
  @moduledoc """
  Transposes text: rows become columns.
  """

  @doc """
  Transposes `input`, a block of `\n`-separated rows, into its
  transposed form.
  """
  @spec transpose(String.t()) :: String.t()
  def transpose(input) do
    input
    |> String.split("\n")
    |> List.foldr([], &prepend_to_columns/2)
    |> Enum.join("\n")
  end

  defp prepend_to_columns(line, columns) when is_binary(line),
    do: prepend_to_columns(String.graphemes(line), columns)
  defp prepend_to_columns([cell | cells], [column_string | column_strings]),
    do: [cell <> column_string | prepend_to_columns(cells, column_strings)]
  defp prepend_to_columns([cell | cells], []), do: [cell | prepend_to_columns(cells, [])]
  defp prepend_to_columns([], [column_string | column_strings]),
    do: [" " <> column_string | prepend_to_columns([], column_strings)]
  defp prepend_to_columns([], []), do: []
  
end
