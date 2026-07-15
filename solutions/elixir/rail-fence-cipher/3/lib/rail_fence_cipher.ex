defmodule RailFenceCipher do

  def encode("", _rails), do: ""
  def encode(plaintext, 1), do: plaintext
  def encode(plaintext, rails), do: encode_by_bounds(plaintext, rails, byte_size(plaintext))

  defp encode_by_bounds(plaintext, rails, total) when total <= rails, do: plaintext
  defp encode_by_bounds(plaintext, rails, total), do:
    zip_encode(generate_zigzag_sequence(total, rails), extract_all_bytes(plaintext, []))

  defp zip_encode(rail_idxs, bytes), do:
    Enum.zip(rail_idxs, bytes)
    |> Enum.sort_by(fn {rail_idx, _byte} -> rail_idx end)
    |> Enum.map_join(fn {_rail_idx, byte} -> byte end)

  def decode("", _rails), do: ""
  def decode(ciphertext, 1), do: ciphertext
  def decode(ciphertext, rails), do: decode_by_bounds(ciphertext, rails, byte_size(ciphertext))

  defp decode_by_bounds(ciphertext, rails, total) when total <= rails, do: ciphertext
  defp decode_by_bounds(ciphertext, rails, total), do:
    zip_decode(generate_orig_pos(total, generate_zigzag_sequence(total, rails)), extract_all_bytes(ciphertext, []))

  defp generate_orig_pos(total, rail_idxs), do:
    0..(total - 1)
    |> Enum.zip(rail_idxs)
    |> Enum.sort_by(fn {_orig_idx, rail_idx} -> rail_idx end)
    |> Enum.map(fn {orig_idx, _rail_idx} -> orig_idx end)

  defp zip_decode(orig_pos, scrambled), do:
    Enum.zip(orig_pos, scrambled)
    |> Enum.sort_by(fn {orig_idx, _byte} -> orig_idx end)
    |> Enum.map_join(fn {_orig_idx, byte} -> byte end)

  defp extract_all_bytes(<<>>, acc), do: Enum.reverse(acc)
  defp extract_all_bytes(<<byte::utf8, rest::binary>>, acc), do:
    extract_all_bytes(rest, [<<byte::utf8>> | acc])

  defp generate_zigzag_sequence(total, rails), do:
    for(char_idx <- 0..(total - 1), do: calculate_rail(char_idx, (rails * 2) - 2, rails))

  defp calculate_rail(char_idx, cycle, rails), do: adjust_position_for_rail(rem(char_idx, cycle), rails, cycle)

  defp adjust_position_for_rail(pos, rails, _cycle) when pos < rails, do: pos
  defp adjust_position_for_rail(pos, _rails, cycle), do: cycle - pos

end
