defmodule LanguageList do

  def new(), do: []
  def add(list, lang), do: [lang | list]
  def remove(list), do: tl(list)
  def first(list), do: hd(list)
  def count(list), do: length(list)
  def functional_list?(list), do: "Elixir" in list

end
