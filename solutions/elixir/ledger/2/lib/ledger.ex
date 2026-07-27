defmodule Ledger do
  @english_header "Date       | Description               | Change       \n"
  @dutch_header   "Datum      | Omschrijving              | Verandering  \n"

  def format_entries(currency, locale, entries) do
    header = locale == :en_US && @english_header || @dutch_header

    entries == [] && header || build_ledger(currency, locale, entries, header)
  end

  defp build_ledger(currency, locale, entries, header) do
    entries
    |> Enum.sort_by(&{&1.date.day, &1.description, &1.amount_in_cents})
    |> Enum.map(&format_entry(currency, locale, &1))
    |> Enum.join("\n")
    |> then(&(header <> &1 <> "\n"))
  end

  defp format_entry(currency, locale, entry) do
    date        = format_date(locale, entry.date)
    number      = format_number(locale, entry.amount_in_cents)
    amount      = format_amount(locale, currency, number, entry.amount_in_cents >= 0)
    description = format_description(entry.description)

    date <> "|" <> description <> " |" <> amount
  end

  defp format_date(locale, date) do
    year  = to_string(date.year)
    month = date.month |> to_string() |> String.pad_leading(2, "0")
    day   = date.day   |> to_string() |> String.pad_leading(2, "0")

    locale == :en_US && month <> "/" <> day <> "/" <> year <> " " ||
    day <> "-" <> month <> "-" <> year <> " "
  end

  defp format_number(locale, amount_in_cents) do
    abs_cents = abs(amount_in_cents)
    decimal   = abs_cents |> rem(100) |> to_string() |> String.pad_leading(2, "0")
    whole_val = div(abs_cents, 100)

    thou_sep = locale == :en_US && "," || "."
    dec_sep  = locale == :en_US && "." || ","

    whole =
      whole_val < 1000 && to_string(whole_val) ||
      to_string(div(whole_val, 1000)) <> thou_sep <> to_string(rem(whole_val, 1000))

    whole <> dec_sep <> decimal
  end

  defp format_amount(locale, currency, number, is_positive) do
    symbol = currency == :eur && "€" || "$"

    raw =
      is_positive && (
        locale == :en_US && "  #{symbol}#{number} " || 
        " #{symbol} #{number} "
      ) || (
        locale == :en_US && " (#{symbol}#{number})" || 
        " #{symbol} -#{number} "
      )

    String.pad_leading(raw, 14, " ")
  end

  defp format_description(description) do
    String.length(description) > 26 &&
      " " <> String.slice(description, 0, 22) <> "..." ||
      " " <> String.pad_trailing(description, 25, " ")
  end
end
