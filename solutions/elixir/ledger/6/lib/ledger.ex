defmodule Ledger do
  @type currency :: :usd | :eur
  @type locale :: :en_US | :nl_NL
  @type entry :: %{amount_in_cents: integer(), date: Date.t(), description: String.t()}

  @spec format_entries(currency(), locale(), list(entry())) :: String.t()
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
      entry.description,
      format_cent_amount(locale, currency, entry.amount_in_cents) |> String.pad_leading(13, " ")
    ])
  end

  defp format_line([date, description, change]) do
    [cell(date, 10), cell(description, 25), cell(change, 13)]
    |> Enum.join(" | ")
  end

  defp cell(content, width) do
    if String.length(content) <= width do
      String.pad_trailing(content, width)
    else
      String.slice(content, 0, width - 3) <> "..."
    end
  end

  defp format_date(:en_US, date) do
    to_string(:io_lib.format("~2..0B/~2..0B/~4..0B", [date.month, date.day, date.year]))
  end

  defp format_date(:nl_NL, date) do
    to_string(:io_lib.format("~2..0B-~2..0B-~4..0B", [date.day, date.month, date.year]))
  end

  defp format_cent_amount(locale, currency, in_cents) do
    with sign <- in_cents >= 0,
         cents <- rem(abs(in_cents), 100),
         fulls <- div(abs(in_cents), 100),
         ones <- rem(fulls, 1000),
         thousands <- div(fulls, 1000),
         formatted_number <- format_in_groups(locale, thousands, ones, cents),
         do: format_sign_and_currency(locale, currency, sign, formatted_number)
  end

  defp format_in_groups(:en_US, 0, ones, cents) do
    to_string(:io_lib.format("~..0B.~2..0B", [ones, cents]))
  end

  defp format_in_groups(:en_US, thousands, ones, cents) do
    to_string(:io_lib.format("~.. B,~3..0B.~2..0B", [thousands, ones, cents]))
  end

  defp format_in_groups(:nl_NL, 0, ones, cents) do
    to_string(:io_lib.format("~..0B,~2..0B", [ones, cents]))
  end

  defp format_in_groups(:nl_NL, thousands, ones, cents) do
    to_string(:io_lib.format("~.. B.~3..0B,~2..0B", [thousands, ones, cents]))
  end

  defp format_sign_and_currency(:en_US, :usd, true, number),  do: "$#{number} "
  defp format_sign_and_currency(:en_US, :eur, true, number),  do: "€#{number} "
  defp format_sign_and_currency(:en_US, :usd, false, number), do: "($#{number})"
  defp format_sign_and_currency(:en_US, :eur, false, number), do: "(€#{number})"
  defp format_sign_and_currency(:nl_NL, :usd, true, number),  do: "$ #{number} "
  defp format_sign_and_currency(:nl_NL, :eur, true, number),  do: "€ #{number} "
  defp format_sign_and_currency(:nl_NL, :usd, false, number),  do: "$ -#{number} "
  defp format_sign_and_currency(:nl_NL, :eur, false, number),  do: "€ -#{number} "
end