defmodule Hamming do

  def hamming_distance(strand1, strand2)
    when length(strand1) != length(strand2) do
      {:error, "strands must be of equal length"}
  end

  def hamming_distance(strand1, strand2) do
    count = Enum.zip(strand1, strand2)
    |> Enum.count(fn {nuc1, nuc2} -> nuc1 != nuc2 end)

    {:ok, count}
  end

end
