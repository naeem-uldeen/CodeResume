defmodule Sublist do

  def compare(list_a, list_b) do
    cond do
      list_a == list_b          -> :equal
      contains?(list_b, list_a) -> :sublist
      contains?(list_a, list_b) -> :superlist
      :else                     -> :unequal
    end
  end

  defp contains?([_ | tail] = list, sublist), do:
    List.starts_with?(list, sublist) or contains?(tail, sublist)
  defp contains?([], _), do: false

end
