defmodule IsbnVerifier do

  @spec isbn?(String.t()) :: boolean()
  def isbn?(isbn),
    do: with digits <- normalize(isbn),
    do: validate(digits)

  @spec normalize(String.t()) :: charlist()
  defp normalize(isbn),
    do: String.to_charlist(String.replace(isbn, "-", ""))

  @spec validate(charlist()) :: boolean()
  defp validate(digits) when length(digits) != 10, do: false
  defp validate(digits) do
    {first9, last} = Enum.split(digits, 9)
    first9_valid? = Enum.all?(first9, &(&1 >= ?0 and &1 <= ?9))
    last_valid? = last == [?X] or (Enum.all?(last, &(&1 >= ?0 and &1 <= ?9)))
    first9_valid? and last_valid? and
      rem(checksum(digits), 11) == 0
  end

  @spec checksum(charlist()) :: integer()
  defp checksum(digits) do
    digits
    |> Enum.with_index(1)
    |> Enum.map(&weighted_value/1)
    |> Enum.sum()
  end

  @spec weighted_value({integer(), integer()}) :: integer()
  defp weighted_value({?X, position}) when
    position == 10,
    do: 10 * position
  defp weighted_value({?X, _position}), do: 0
  defp weighted_value({digit, position}),
    do: (digit - ?0) * position

end
