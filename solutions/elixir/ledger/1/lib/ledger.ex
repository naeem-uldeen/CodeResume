defmodule Ledger do
  @english_header "Date       | Description               | Change       \n"
  @dutch_header   "Datum      | Omschrijving              | Verandering  \n"

  def format_entries(currency, locale, entries) do
    header = locale == :en_US && @english_header || @dutch_header
    entries == [] && header ||
      (entries
       |> Enum.sort_by(&{&1.date.day, &1.description, &1.amount_in_cents})
       |> Enum.map(&format_entry(currency, locale, &1))
       |> Enum.join("\n")
       |> (&(header <> &1 <> "\n")).())
  end

  defp format_entry(currency, locale, entry) do
    year  = entry.date.year  |> to_string()
    month = entry.date.month |> to_string() |> String.pad_leading(2, "0")
    day   = entry.date.day   |> to_string() |> String.pad_leading(2, "0")
    date =
      locale == :en_US && month <> "/" <> day <> "/" <> year <> " " ||
      day <> "-" <> month <> "-" <> year <> " "
    symbol    = currency == :eur && "€" || "$"
    abs_cents = abs(entry.amount_in_cents)
    decimal   = abs_cents |> rem(100) |> to_string() |> String.pad_leading(2, "0")
    whole_val = div(abs_cents, 100)
    thou_sep = locale == :en_US && "," || "."
    dec_sep  = locale == :en_US && "." || ","
    whole =
      whole_val < 1000 && to_string(whole_val) ||
      to_string(div(whole_val, 1000)) <> thou_sep <> to_string(rem(whole_val, 1000))
    number = whole <> dec_sep <> decimal
    amount = String.pad_leading(
      entry.amount_in_cents >= 0 && (
        locale == :en_US && "  #{symbol}#{number} " || " #{symbol} #{number} "
      ) || (
        locale == :en_US && " (#{symbol}#{number})" || " #{symbol} -#{number} "
      ),
      14,
      " "
    )

    description =
      entry.description |> String.length() > 26 &&
      " " <> String.slice(entry.description, 0, 22) <> "..." ||
      " " <> String.pad_trailing(entry.description, 25, " ")

    date <> "|" <> description <> " |" <> amount
  end
end
