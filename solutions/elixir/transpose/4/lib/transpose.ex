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

  defp prepend_to_columns(<<cell::utf8, cells::binary>>, [column | columns]),
    do: [<<cell::utf8, column::binary>> | prepend_to_columns(cells, columns)]
  defp prepend_to_columns(<<>>, columns), do: Enum.map(columns, &(" " <> &1))
  defp prepend_to_columns(row, []), do: for(<<cell::utf8 <- row>>, do: <<cell::utf8>>)
  
end
