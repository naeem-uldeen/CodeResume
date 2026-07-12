defmodule Dominoes do
  @type domino :: {1..6, 1..6}

  @spec chain?(dominoes :: [domino]) :: boolean
  def chain?([]), do: true
  def chain?([{start, current_end}]), do: start == current_end

  def chain?([{start, current_end} | free_dominoes]) do
    Enum.find_value(free_dominoes, false, fn
      {^current_end, new_end} = domino ->
        chain?([{start, new_end} | List.delete(free_dominoes, domino)])
      {new_end, ^current_end} = domino ->
        chain?([{start, new_end} | List.delete(free_dominoes, domino)])
      _ -> false
    end)
  end
end
