defmodule Sublist do

  def compare(list_a, list_b) when list_a == list_b, do: :equal
  def compare(list_a, list_b) do
    cond do
      sublist?(list_a, list_b) -> :sublist
      sublist?(list_b, list_a) -> :superlist
      true                     -> :unequal
    end
  end

  defp starts_with?(_, []),                                   do: true
  defp starts_with?([], _),                                   do: false
  defp starts_with?([head | tail], [head | prefix_tail]),     do: starts_with?(tail, prefix_tail)
  defp starts_with?(_, _),                                    do: false

  defp sublist?(_, []),                                       do: false
  defp sublist?(list_a, [_ | tail] = list_b) do
    if starts_with?(list_b, list_a), do: true, else: sublist?(list_a, tail)
  end

end


