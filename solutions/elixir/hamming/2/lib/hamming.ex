defmodule Hamming do
  
  def hamming_distance(strand1, strand2), do: differences(strand1, strand2)

  # Private recursive function with accumulator for difference count
  # The third parameter defaults to 0 when called from hamming_distance/2
  defp differences(strand1, strand2, differences \\ 0)

  # Same characters: move to next without incrementing count
  defp differences([nuc | remaining_strand1], [nuc | remaining_strand2], differences), 
    do: differences(remaining_strand1, remaining_strand2, differences)

  # Different characters: move to next and increment count by 1
  defp differences([_nuc1 | remaining_strand1], [_nuc2 | remaining_strand2], differences), 
    do: differences(remaining_strand1, remaining_strand2, differences + 1)

  # Both strands exhausted: return accumulated differences
  defp differences([], [], differences), 
    do: {:ok, differences}

  # First strand longer: length mismatch error
  defp differences([_ | _], [], _differences), 
    do: {:error, "strands must be of equal length"}

  # Second strand longer: length mismatch error
  defp differences([], [_ | _], _differences), 
    do: {:error, "strands must be of equal length"}
    
end
