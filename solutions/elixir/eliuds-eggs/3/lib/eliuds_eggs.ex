defmodule EliudsEggs do
  use Bitwise

  def egg_count(n),      do: do_count(n, 0)

  defp do_count(0, acc), do: acc
  defp do_count(n, acc), do: do_count(n >>> 1, acc + (n &&& 1))
  
end
