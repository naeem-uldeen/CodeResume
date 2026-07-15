defmodule RailFenceCipher do

  def encode("", _rails), do: ""
  def encode(plaintext, 1), do: plaintext
  def encode(plaintext, rails) do
    total = byte_size(plaintext)
    encode_by_bounds(plaintext, rails, total)
  end

  defp encode_by_bounds(plaintext, rails, total) when total <= rails, do: plaintext
  defp encode_by_bounds(plaintext, rails, total) do
    rail_idxs = generate_zigzag_sequence(total, rails)
    bytes = extract_all_bytes(plaintext, 0, total, [])
    
    Enum.zip(rail_idxs, bytes)
    |> Enum.sort_by(fn {rail_idx, _byte} -> rail_idx end)
    |> Enum.map_join(fn {_rail_idx, byte} -> byte end)
  end

  def decode("", _rails), do: ""
  def decode(ciphertext, 1), do: ciphertext  
  def decode(ciphertext, rails) do
    total = byte_size(ciphertext)
    decode_by_bounds(ciphertext, rails, total)
  end

  defp decode_by_bounds(ciphertext, rails, total) when total <= rails, do: ciphertext
  defp decode_by_bounds(ciphertext, rails, total) do
    rail_idxs = generate_zigzag_sequence(total, rails)
    
    orig_pos = 
      0..(total - 1)
      |> Enum.zip(rail_idxs)
      |> Enum.sort_by(fn {_orig_idx, rail_idx} -> rail_idx end)
      |> Enum.map(fn {orig_idx, _rail_idx} -> orig_idx end)
      
    scrambled = extract_all_bytes(ciphertext, 0, total, [])
    
    Enum.zip(orig_pos, scrambled)
    |> Enum.sort_by(fn {orig_idx, _byte} -> orig_idx end)
    |> Enum.map_join(fn {_orig_idx, byte} -> byte end)
  end

  defp extract_all_bytes(_binary, idx, total, acc) when idx == total, do: Enum.reverse(acc)
  defp extract_all_bytes(binary, idx, total, acc) do
    case binary do
      <<_skip::binary-size(idx), byte::utf8, _rem::binary>> ->
        extract_all_bytes(binary, idx + 1, total, [<<byte>> | acc])
      _out_of_bounds ->
        Enum.reverse(acc)
    end
  end

  defp generate_zigzag_sequence(total, rails) do
    cycle = (rails * 2) - 2
    for char_idx <- 0..(total - 1), do: calculate_rail(char_idx, cycle, rails)
  end

  defp calculate_rail(char_idx, cycle, rails) do
    pos = rem(char_idx, cycle)
    adjust_position_for_rail(pos, rails, cycle)
  end

  defp adjust_position_for_rail(pos, rails, _cycle) when pos < rails, do: pos
  defp adjust_position_for_rail(pos, _rails, cycle), do: cycle - pos
  
end
