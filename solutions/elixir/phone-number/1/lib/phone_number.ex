defmodule PhoneNumber do

  def clean(raw) do
    with :ok <- validate_raw_characters(raw),
         digits <- extract_digits(raw),
         :ok <- validate_length(digits),
         number <- strip_country_code(digits),
         :ok <- validate_area_code(number),
         :ok <- validate_exchange_code(number) do
      {:ok, number}
    end
  end

  defp validate_raw_characters(<<character, rest::binary>>) when
    character in ?0..?9,
    do: validate_raw_characters(rest)

  defp validate_raw_characters(<<char, rest::binary>>) when
    char in ' .()-+',
    do: validate_raw_characters(rest)

  defp validate_raw_characters(<<_invalid_char, _rest::binary>>),
    do: {:error, "must contain digits only"}

  defp validate_raw_characters(<<>>), do: :ok

  defp extract_digits(raw), do: extract(raw, "")

  defp extract(<<digit, rest::binary>>, phone_number) when
    digit in ?0..?9,
    do: extract(rest, phone_number <> <<digit>>)

  defp extract(<<_non_digit, rest::binary>>, phone_number),
    do: extract(rest, phone_number)

  defp extract(<<>>, phone_number), do: phone_number

  defp validate_length(digits) do
    case String.length(digits) do
      10 -> :ok
      11 -> validate_country_code(digits)
      n when n < 10 -> {:error, "must not be fewer than 10 digits"}
      _ -> {:error, "must not be greater than 11 digits"}
    end
  end

  defp validate_country_code("1" <> _rest), do: :ok
  defp validate_country_code(_), do: {:error, "11 digits must start with 1"}

  defp strip_country_code("1" <> rest = digits) when
    byte_size(digits) == 11,
    do: rest

  defp strip_country_code(other), do: other

  defp validate_area_code(<<?0, _rest::binary>>),
    do: {:error, "area code cannot start with zero"}

  defp validate_area_code(<<?1, _rest::binary>>),
    do: {:error, "area code cannot start with one"}

  defp validate_area_code(_), do: :ok

  defp validate_exchange_code(<<_, _, _, ?0, _rest::binary>>),
    do: {:error, "exchange code cannot start with zero"}

  defp validate_exchange_code(<<_, _, _, ?1, _rest::binary>>),
    do: {:error, "exchange code cannot start with one"}

  defp validate_exchange_code(_), do: :ok
  
end
