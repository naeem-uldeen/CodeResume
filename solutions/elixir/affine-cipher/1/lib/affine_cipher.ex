defmodule AffineCipher do

  def encode(key, message) do
    with(
      {:ok, encoder, _} <- encoder_and_decoder(key),
      encoded =
        message
        |> String.to_charlist()
        |> Enum.map(encoder)
        |> Enum.reject(&(&1 == :not_encoded))
        |> Enum.chunk_every(5)
        |> Enum.join(" "),
      do: {:ok, encoded}
    )
  end

  def decode(key, message) do
    with(
      {:ok, _, decoder} <- encoder_and_decoder(key),
      decoded =
        message
        |> String.to_charlist()
        |> Enum.map(decoder)
        |> Enum.reject(&(&1 == :not_encoded))
        |> List.to_string(),
      do: {:ok, decoded}
    )
  end

  defp encoder_and_decoder(%{a: a, b: b}) do
    m = ?z - ?a + 1

    if coprime?(m, a) do
      mmi_a = 1..m |> Enum.find(fn x -> Integer.mod(a * x, m) == 1 end)

      encoder = fn
        d when d in ?0..?9 -> d
        c when c in ?a..?z -> ?a + Integer.mod(a * (c - ?a) + b, m)
        c when c in ?A..?Z -> ?a + Integer.mod(a * (c - ?A) + b, m)
        _ -> :not_encoded
      end

      decoder = fn
        d when d in ?0..?9 -> d
        c when c in ?a..?z -> ?a + Integer.mod(mmi_a * (c - ?a - b), m)
        _ -> :not_encoded
      end
      {:ok, encoder, decoder}
    else
      {:error, "a and m must be coprime."}
    end
  end

  defp coprime?(x, y) do
    Enum.all?(2..min(x, y), fn d ->
      Integer.mod(x, d) > 0 or Integer.mod(y, d) > 0
    end)
  end
  
end
