defmodule Luhn do

  def valid?(digits) do
    digits
    |> String.replace(" ", "")
    |> String.to_charlist()
    |> validate()
  end

  defp validate(digits) when
    length(digits) <= 1, do: false
  defp validate(digits) do
    Enum.all?(digits, &(&1 >= ?0 and &1 <= ?9)) and
      rem(checksum(digits), 10) == 0
  end

  defp checksum(digits) do
    digits
    |> Enum.reverse()
    |> Enum.with_index()
    |> Enum.map(&adjust/1)
    |> Enum.sum()
  end

  defp adjust({digit, index}) when
    rem(index, 2) == 1, do: adjust(digit)
  defp adjust({digit, _index}), do: digit - ?0
  defp adjust(digit) do
    doubled = (digit - ?0) * 2
    if doubled > 9, do: doubled - 9, else: doubled
  end

end
