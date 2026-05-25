defmodule BoutiqueSuggestions do

  def get_combinations(shirts, pants, filters \\ []) do
    budget = Keyword.get(filters, :maximum_price, 100.00)
    for shirt <- shirts, pant <- pants,
        shirt.base_color != pant.base_color,
        shirt.price + pant.price <= budget,
        do: {shirt, pant}
  end
  
end
