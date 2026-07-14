defmodule CryptoSquare do

  def encode(""), do: ""
  def encode(message) do
    message
    |> normalize()
    |> build_square()
  end

  defp normalize(message) do
    message
    |> String.downcase()
    |> String.replace(~r/[^a-z0-9]/, "")
  end

  defp build_square(""), do: ""
  defp build_square(normalized) do
    length = String.length(normalized)
    num_cols = length |> :math.sqrt() |> Float.ceil() |> trunc()
    num_rows = (length / num_cols) |> Float.ceil() |> trunc()

    normalized
    |> String.pad_trailing(num_rows * num_cols)
    |> String.to_charlist()
    |> Enum.chunk_every(num_cols)
    |> transpose([])
    |> Enum.map(&List.to_string/1)
    |> Enum.join(" ")
  end

  defp transpose([[] | _], acc), do: Enum.reverse(acc)
  defp transpose(rows, acc) do
    heads = Enum.map(rows, &hd/1)
    tails = Enum.map(rows, &tl/1)
    transpose(tails, [heads | acc])
  end
  
end
