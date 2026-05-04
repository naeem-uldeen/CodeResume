defmodule Luhn do

  @spec valid?(String.t()) :: boolean()
  def valid?(digits),
    do: with digits <- normalize(digits),
    do: validate(digits)

  @spec normalize(String.t()) :: charlist()
  defp normalize(digits),
    do: String.to_charlist(String.replace(digits, " ", ""))

  @spec validate(charlist()) :: boolean()
  defp validate(digits) when length(digits) <= 1, do: false
  defp validate(digits) do
    Enum.all?(digits, &(&1 >= ?0 and &1 <= ?9)) and
      rem(checksum(digits), 10) == 0
  end

  @spec checksum(charlist()) :: integer()
  defp checksum(digits) do
    digits
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.map(&adjust/1)
    |> Enum.sum()
  end

  @spec adjust({integer(), integer()}) :: integer()
  defp adjust({digit, index}) when
    rem(index, 2) == 1, do: adjust(digit)
  defp adjust({digit, _index}), do: digit - ?0

  @spec adjust(integer()) :: integer()
  defp adjust(digit) do
    doubled = (digit - ?0) * 2
    if doubled > 9,
      do:   doubled - 9,
      else: doubled
  end

end
