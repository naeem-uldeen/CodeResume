defmodule CryptoSquare do

  def encode(""), do: ""
  def encode(message) do
    normalized_message = String.downcase(String.replace(message, ~r/[[:punct:]|\s]/, ""))
    total_bytes = byte_size(normalized_message)

    if total_bytes == 0 do
      ""
    else
      num_cols = :math.sqrt(total_bytes) |> Float.ceil() |> trunc()
      num_rows = :math.ceil(total_bytes / num_cols) |> trunc()

      for col_idx <- 0..(num_cols - 1), into: [] do
        extract_column_bytes(normalized_message, col_idx, num_cols, num_rows, 0, "")
      end
      |> Enum.join(" ")
    end
  end

  defp extract_column_bytes(_binary, _col_idx, _stride, num_rows, curr_row, acc) when curr_row == num_rows, do: acc
  defp extract_column_bytes(binary, col_idx, stride, num_rows, curr_row, acc) do
    byte_offset = curr_row * stride + col_idx

    case binary do
      <<_skip_bytes::binary-size(byte_offset), matched_byte::utf8, _remaining_bytes::binary>> ->
        extract_column_bytes(binary, col_idx, stride, num_rows, curr_row + 1, acc <> <<matched_byte>>)
      _out_of_bounds ->
        extract_column_bytes(binary, col_idx, stride, num_rows, curr_row + 1, acc <> " ")
    end
  end

end
