defmodule FlattenArray do

  def flatten(list), do: flat(list)

  defp flat([]), do: []
  defp flat([nil | tl]), do: flat(tl)
  defp flat([hd | tl]) when is_list(hd), do: flat(hd) ++ flat(tl)
  defp flat([hd | tl]), do: [hd | flat(tl)]

end
