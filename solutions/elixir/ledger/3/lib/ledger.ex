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
    |> Enum.map_join("\n", &format_entry(currency, locale, &1))
    |> then(&"#{header}#{&1}\n")
  end

  defp format_entry(currency, locale, entry) do
    cents = entry.amount_in_cents
    date        = format_date(locale, entry.date)
    number      = format_number(locale, cents)
    amount      = format_amount(locale, currency, number, cents >= 0)
    description = format_description(entry.description)

    "#{date}|#{description} |#{amount}"
  end

  defp format_date(locale, %{year: y, month: m, day: d}) do
    [year, month, day] = [y, m, d] |> Enum.map(&to_string/1) |> Enum.map(&String.pad_leading(&1, 2, "0"))
    locale == :en_US && "#{month}/#{day}/#{year} " || "#{day}-#{month}-#{year} "
  end

  defp format_number(locale, amount_in_cents) do
    abs_cents = abs(amount_in_cents)
    decimal   = rem(abs_cents, 100) |> to_string() |> String.pad_leading(2, "0")
    whole_val = div(abs_cents, 100)
    thou_sep = locale == :en_US && "," || "."
    dec_sep  = locale == :en_US && "." || ","
    whole = whole_val < 1000 && to_string(whole_val) || "#{div(whole_val, 1000)}#{thou_sep}#{rem(whole_val, 1000)}"

    "#{whole}#{dec_sep}#{decimal}"
  end

  defp format_amount(locale, currency, number, is_positive) do
    en_us  = locale == :en_US
    symbol = currency == :eur && "€" || "$"
    raw =
      is_positive && (
        en_us && "  #{symbol}#{number} " || " #{symbol} #{number} "
      ) || (
        en_us && " (#{symbol}#{number})" || " #{symbol} -#{number} "
      )

    String.pad_leading(raw, 14, " ")
  end

  defp format_description(description) do
    text = String.length(description) > 26 && String.slice(description, 0, 22) <> "..." || String.pad_trailing(description, 25, " ")
    " #{text}"
  end
end
