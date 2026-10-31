defmodule Diamond do
  @doc """
  Given a letter, it prints a diamond starting with 'A',
  with the supplied letter at the widest point.
  """
  @spec build_shape(char) :: String.t()
  def build_shape(letter) when letter in ?A..?Z do
    [_widest | below] = descending = rows(?A, letter, [])

    Enum.map_join(Enum.reverse(descending, below), &(&1 <> "\n"))
  end

  defp rows(letter, last, acc) when letter > last, do: acc
  defp rows(letter, last, acc),
    do: rows(letter + 1, last, [row(letter, last - ?A) | acc])

  defp row(?A, last_index), do: pad(last_index) <> "A" <> pad(last_index)
  defp row(letter, last_index) do
    index = letter - ?A
    margin = pad(last_index - index)

    margin <> <<letter>> <> pad(2 * index - 1) <> <<letter>> <> margin
  end

  defp pad(count), do: String.duplicate(" ", count)
end
