defmodule LanguageList do

  def new(), do: []

  def add(list, lang), do: [lang | list]

  def remove([_ | tail]), do: tail

  def first([head | _]), do: head

  def count([]),          do: 0
  def count([_ | tail]),  do: 1 + count(tail)

  def functional_list?([]),                do: false
  def functional_list?(["Elixir" | _]),    do: true
  def functional_list?([_ | tail]),        do: functional_list?(tail)
  
end
