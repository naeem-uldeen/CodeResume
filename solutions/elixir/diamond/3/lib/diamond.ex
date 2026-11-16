defmodule Diamond do
  @moduledoc """
  Builds a diamond of letters: `A` at the top and bottom,
  the supplied letter at the widest point.
  """

  @doc """
  Given a letter, it prints a diamond starting with 'A',
  with the supplied letter at the widest point.
  """
  @spec build_shape(char) :: String.t()
  def build_shape(widest) when widest in ?A..?Z do
    top = ?A..widest
    bottom = (widest - 1)..?A//-1

    top |> Enum.concat(bottom) |> Enum.map_join(&(row(&1, widest) <> "\n"))
  end

  @spec row(char, char) :: String.t()
  defp row(letter, widest) do
    margin = pad(widest - letter)

    margin <> inner(letter) <> margin
  end

  @spec inner(char) :: String.t()
  defp inner(?A), do: "A"
  defp inner(letter), do: <<letter>> <> pad(2 * (letter - ?A) - 1) <> <<letter>>

  @spec pad(non_neg_integer) :: String.t()
  defp pad(count), do: String.duplicate(" ", count)
end
