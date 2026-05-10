defmodule WineCellar do

  def explain_colors do
    [
      white: "Fermented without skin contact.",
      red:   "Fermented with skin contact using dark-colored grapes.",
      rose:  "Fermented with some skin contact, but not enough to qualify as a red wine."
    ]
  end

  def filter(cellar, color, options \\ []) do
    cellar
    |> wines_of_color(color)
    |> optionally_filter(options[:year],    &filter_by_year/2)
    |> optionally_filter(options[:country], &filter_by_country/2)
  end

  defp wines_of_color(cellar, color),
    do: Keyword.get_values(cellar, color)

  defp optionally_filter(wines, nil, _), do: wines
  defp optionally_filter(wines, criterion, filter_func)
    when is_function(filter_func, 2),
      do: filter_func.(wines, criterion)

  defp filter_by_year(wines, year)
  defp filter_by_year([], _year), do: []
  defp filter_by_year([{_, year, _} = wine | remaining_wines], year) do
    [wine | filter_by_year(remaining_wines, year)]
  end
  defp filter_by_year([{_, _, _} | remaining_wines], year) do
    filter_by_year(remaining_wines, year)
  end

  defp filter_by_country(wines, country)
  defp filter_by_country([], _country), do: []
  defp filter_by_country([{_, _, country} = wine | remaining_wines], country) do
    [wine | filter_by_country(remaining_wines, country)]
  end
  defp filter_by_country([{_, _, _} | remaining_wines], country) do
    filter_by_country(remaining_wines, country)
  end
  
end


