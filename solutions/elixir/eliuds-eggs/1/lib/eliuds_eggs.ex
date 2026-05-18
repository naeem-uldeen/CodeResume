defmodule EliudsEggs do

  def egg_count(0),                     do: 0
  def egg_count(n) when rem(n, 2) == 1, do: 1 + egg_count(div(n, 2))
  def egg_count(n),                     do: egg_count(div(n, 2))
  
end
