defmodule BoutiqueSuggestions do

  def get_combinations(tops, bottoms, opts \\ []) do
    maximum_price = opts[:maximum_price] || 100.00

    for top <- tops, bottom <- bottoms,
        top.base_color != bottom.base_color,
        top.price + bottom.price <= maximum_price,
    do: {top, bottom}
  end

end
