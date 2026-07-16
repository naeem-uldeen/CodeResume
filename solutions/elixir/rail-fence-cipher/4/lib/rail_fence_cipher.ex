defmodule RailFenceCipher do
  def encode("", _), do: ""
  def encode(original, 1), do: original
  def encode(original, rails) when rails > 0,
    do:
      char_indices_to_encode(byte_size(original), rails)
      |> Enum.map_join("", &binary_part(original, &1, 1))

  def decode("", _), do: ""
  def decode(encoded, 1), do: encoded
  def decode(encoded, rails) when rails > 0,
    do:
      char_indices_to_encode(byte_size(encoded), rails)
      |> Enum.with_index(0)
      |> Enum.sort_by(fn {index_in_original, _index_in_encoded} -> index_in_original end)
      |> Enum.map_join("", fn {_index_in_original, index_in_encoded} ->
        binary_part(encoded, index_in_encoded, 1) end)

  defp char_indices_to_encode(total, rails) do
    cycle = 2 * rails - 2

    0..(total - 1)
    |> Enum.sort_by(fn index ->
      position_in_cycle = rem(index, cycle)
      min(position_in_cycle, cycle - position_in_cycle)
    end)
  end
end
