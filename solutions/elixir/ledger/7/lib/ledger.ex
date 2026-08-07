defmodule Ledger do
  @type currency :: :usd | :eur
  @type locale :: :en_US | :nl_NL
  @type entry :: %{amount_in_cents: integer(), date: Date.t(), description: String.t()}

  @spec format_entries(currency(), locale(), list(entry())) :: String.t()
  def format_entries(_currency, locale, [] = _empty_ledger), do: """
  #{header_line(locale)}
  """

  def format_entries(currency, locale, entries), do: """
  #{header_line(locale)}
  #{Enum.map_join(sort(entries), "\n", &data_line(currency, locale, &1))}
  """

  defp sort(entries), do: Enum.sort_by(entries, &{&1.date, &1.description, &1.amount_in_cents})

  defp header_line(:en_US), do: format_line(["Date", "Description", "Change"])
  defp header_line(:nl_NL), do: format_line(["Datum", "Omschrijving", "Verandering"])

  defp format_line([date, description, change]), do: "#{cell(date, 10)} | #{cell(description, 25)} | #{cell(change, 13)}"

  defp cell(content, width),
    do: if(String.length(content) <= width, do: String.pad_trailing(content, width), else: String.slice(content, 0, width - 3) <> "...")

  defp data_line(currency, locale, entry),
    do: format_line([
      format_date(locale, entry.date),
      entry.description,
      format_cent_amount(locale, currency, entry.amount_in_cents) |> String.pad_leading(13, " ")
    ])

  defp format_date(:en_US, date), do: Calendar.strftime(date, "%m/%d/%Y")
  defp format_date(:nl_NL, date), do: Calendar.strftime(date, "%d-%m-%Y")

  defp format_cent_amount(locale, currency, in_cents),
    do: with(
      {sep, decimal_point} <- thousands_sep_and_decimal_point(locale),
      cents = rem(abs(in_cents), 100),
      fulls = div(abs(in_cents), 100),
      ones = rem(fulls, 1000),
      thousands = div(fulls, 1000),
      amount = to_string(if(thousands > 0,
        do: :io_lib.format("~.. B#{sep}~3..0B#{decimal_point}~2..0B", [thousands, ones, cents]),
        else: :io_lib.format("~..0B#{decimal_point}~2..0B", [ones, cents])
      )),
      do: format_with_sign_and_currency(locale, currency_symbol(currency), in_cents < 0, amount)
    )

  defp thousands_sep_and_decimal_point(:en_US), do: {",", "."}
  defp thousands_sep_and_decimal_point(:nl_NL), do: {".", ","}

  defp currency_symbol(:usd), do: "$"
  defp currency_symbol(:eur), do: "€"

  defp format_with_sign_and_currency(:en_US, currency, false, amount), do: "#{currency}#{amount} "
  defp format_with_sign_and_currency(:en_US, currency, true, amount),  do: "(#{currency}#{amount})"
  defp format_with_sign_and_currency(:nl_NL, currency, false, amount), do: "#{currency} #{amount} "
  defp format_with_sign_and_currency(:nl_NL, currency, true, amount),  do: "#{currency} -#{amount} "
end
