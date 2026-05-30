defmodule Strain do

  @spec keep(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def keep(list, fun), do: do_keep(list, fun, [])

  defp do_keep([], _fun, acc), do: Enum.reverse(acc)
  defp do_keep([hd | tl], fun, acc), do: do_keep(tl, fun, acc, fun.(hd), hd)

  defp do_keep(tl, fun, acc, true,  hd),  do: do_keep(tl, fun, [hd | acc])
  defp do_keep(tl, fun, acc, false, _hd), do: do_keep(tl, fun, acc)

  @spec discard(list :: list(any), fun :: (any -> boolean)) :: list(any)
  def discard(list, fun), do: keep(list, &(not fun.(&1)))

end
