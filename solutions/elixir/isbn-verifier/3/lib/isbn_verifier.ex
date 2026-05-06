defmodule IsbnVerifier do

  def isbn?(isbn),
    do: isbn 
    |> String.replace("-", "") 
    |> String.to_charlist() 
    |> valid?(1, 0)

  defp valid?([], 11, checksum), do: rem(checksum, 11) == 0
  
  defp valid?([], _position, _checksum), do: false
  
  defp valid?([?X | remaining], 10, checksum),
    do: valid?(remaining, 11, checksum + 100)
    
  defp valid?([digit | remaining], position, checksum) when
    digit >= ?0 and digit <= ?9,
    do: valid?(remaining, position + 1, checksum + (digit - ?0) * position)
    
  defp valid?([_invalid | _remaining], _position, _checksum), do: false
  
end
