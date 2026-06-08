defmodule FlattenArray do

  def flatten(list), do: flat(list, [])

  defp flat([], acc),                         do: Enum.reverse(acc)
  defp flat([nil | tl], acc),                 do: flat(tl, acc)
  defp flat([[hd | inner_tl] | tl], acc),     do: flat([hd | [inner_tl | tl]], acc)
  defp flat([[] | tl], acc),                  do: flat(tl, acc)
  defp flat([hd | tl], acc),                  do: flat(tl, [hd | acc])

end
