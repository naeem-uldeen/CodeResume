defmodule EliudsEggs do
  use Bitwise

  def egg_count(0), do: 0
  def egg_count(n), do: (n &&& 1) + egg_count(n >>> 1)
  
end
