defmodule Rules do

  def eat_ghost?(pellet_active?, touching_ghost?),
    do: pellet_active? and touching_ghost?

  def score?(touching_pellet?, touching_dot?),
    do: touching_pellet? or touching_dot?

  def lose?(pellet_active?, touching_ghost?),
    do: not pellet_active? and touching_ghost?

  def win?(eaten_all_dots?, pellet_active?, touching_ghost?),
    do: eaten_all_dots? and not lose?(pellet_active?, touching_ghost?)

end
