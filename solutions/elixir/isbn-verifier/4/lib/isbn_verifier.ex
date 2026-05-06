defmodule IsbnVerifier do

  def isbn?(isbn), do: valid?(isbn, 10, 0)

  defp valid?("", 0, checksum), do: rem(checksum, 11) == 0

  defp valid?(<< ?- , rest::binary >>, position, checksum),
    do: valid?(rest, position, checksum)

  defp valid?(<< ?X , rest::binary >>, 1, checksum),
    do: valid?(rest, 0, checksum + 10)

  defp valid?(<< digit, rest::binary >>, position, checksum)
       when digit in ?0..?9 and position > 0 do
    valid?(rest, position - 1, checksum + (digit - ?0) * position)
  end

  defp valid?(_, _, _), do: false

end
