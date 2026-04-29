defmodule Chessboard do
  # Defined without parens because
  # they are "data providers" (Arity 0)
  def rank_range, do: 1..8
  def file_range, do: ?A..?H

  # Called with parens to satisfy the linter
  # that an action is happening
  def ranks(), do: Enum.to_list(rank_range())

  def files() do
    file_range()
    |> Enum.map(&<<&1>>)
  end

end
