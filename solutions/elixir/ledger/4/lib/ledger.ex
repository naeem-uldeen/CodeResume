defmodule Ledger do
  def format_entries(_currency, locale, [] = _no_entries), do: header_line(locale) <> "\n"
  def format_entries(currency, locale, entries) do
    entries
    |> Enum.sort_by(&{&1.date.day, &1.description, &1.amount_in_cents})
    |> Enum.map_join("\n", &data_line(currency, locale, &1))
    |> then(&"#{header_line(locale)}\n#{&1}\n")
  end

  defp header_line(:en_US), do: format_line(["Date", "Description", "Change"])
  defp header_line(:nl_NL), do: format_line(["Datum", "Omschrijving", "Verandering"])

  defp data_line(currency, locale, entry) do
    format_line([
      format_date(locale, entry.date),
      format_description(entry.description),
      format_amount(locale, currency, entry.amount_in_cents)
    ])
  end

  defp format_line([date, description, change]) do
    [cell(date, 10), cell(description, 25), cell(change, 13)]
    |> Enum.join(" | ")
  end

  defp cell(text, width), do: String.pad_trailing(text, width, " ")

  defp format_date(locale, %{year: y, month: m, day: d}) do
    [year, month, day] = [y, m, d] |> Enum.map(&to_string/1) |> Enum.map(&String.pad_leading(&1, 2, "0"))
    locale == :en_US && "#{month}/#{day}/#{year}" || "#{day}-#{month}-#{year}"
  end

  defp format_number(locale, amount_in_cents) do
    abs_cents = abs(amount_in_cents)
    decimal   = rem(abs_cents, 100) |> to_string() |> String.pad_leading(2, "0")
    whole_val = div(abs_cents, 100)
    thou_sep = locale == :en_US && "," || "."
    dec_sep  = locale == :en_US && "." || ","

    whole =
      whole_val < 1000 && to_string(whole_val) ||
      "#{div(whole_val, 1000)}#{thou_sep}#{rem(whole_val, 1000)}"

    "#{whole}#{dec_sep}#{decimal}"
  end

  defp format_amount(locale, currency, amount_in_cents) do
    en_us  = locale == :en_US
    symbol = currency == :eur && "€" || "$"
    number = format_number(locale, amount_in_cents)
    raw =
      amount_in_cents >= 0 && (
        en_us && "  #{symbol}#{number} " || " #{symbol} #{number} "
      ) || (
        en_us && " (#{symbol}#{number})" || " #{symbol} -#{number} "
      )

    String.pad_leading(raw, 13, " ")
  end

  defp format_description(description) do
    String.length(description) > 26 &&
      String.slice(description, 0, 22) <> "..." ||
      description
  end
end
