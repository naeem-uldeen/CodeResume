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

  defp format_line([date, description, change]), do:
    [cell(date, 10), cell(description, 25), cell(change, 13)]|> Enum.join(" | ")

  defp cell(text, width), do: String.pad_trailing(text, width, " ")

  defp format_date(:en_US, %{year: y, month: m, day: d}), do: join_date([m, d, y], "/")
  defp format_date(_locale, %{year: y, month: m, day: d}), do: join_date([d, m, y], "-")

  defp join_date(parts, separator) do
    parts
    |> Enum.map(&to_string/1)
    |> Enum.map(&String.pad_leading(&1, 2, "0"))
    |> Enum.join(separator)
  end

  defp separators(:en_US), do: {",", "."}
  defp separators(_locale), do: {".", ","}

  defp currency_symbol(:usd), do: "$"
  defp currency_symbol(:eur), do: "€"

  defp format_number(locale, amount_in_cents) do
    {thousands_sep, decimal_sep} = separators(locale)
    abs_cents = abs(amount_in_cents)
    decimal   = abs_cents |> rem(100) |> zero_padded(2)
    whole_val = div(abs_cents, 100)
    thousands = div(whole_val, 1000)
    ones      = rem(whole_val, 1000)
    whole = if thousands == 0 do
      Integer.to_string(ones) else "#{thousands}#{thousands_sep}#{zero_padded(ones, 3)}"
    end

    "#{whole}#{decimal_sep}#{decimal}"
  end

  defp zero_padded(number, width), do: "~#{width}..0B" |> :io_lib.format([number]) |> IO.iodata_to_binary()

  defp format_sign_and_currency(:en_US, true, symbol, number), do: "  #{symbol}#{number} "
  defp format_sign_and_currency(:en_US, false, symbol, number), do: " (#{symbol}#{number})"
  defp format_sign_and_currency(_locale, true, symbol, number), do: " #{symbol} #{number} "
  defp format_sign_and_currency(_locale, false, symbol, number), do: " #{symbol} -#{number} "

  defp format_amount(locale, currency, amount_in_cents) do
    symbol = currency_symbol(currency)
    number = format_number(locale, amount_in_cents)

    locale
    |> format_sign_and_currency(amount_in_cents >= 0, symbol, number)
    |> String.pad_leading(13, " ")
  end

  defp format_description(description) do
    if String.length(description) > 26 do
      String.slice(description, 0, 22) <> "..."
    else
      description
    end
  end
end
