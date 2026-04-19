defmodule LanguageList do

  def new(),               do: []
  def add(langs, lang),    do: [lang | langs]
  def remove([_ | langs]), do: langs
  def first([lang | _]),   do: lang
  
  def count([]),           do: 0
  def count([_ | langs]),  do: 1 + count(langs)

  def functional_list?([]),             do: false
  def functional_list?(["Elixir" | _]), do: true
  def functional_list?([_ | langs]),    do: functional_list?(langs)
  
end