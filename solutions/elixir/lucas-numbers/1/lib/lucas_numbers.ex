defmodule LucasNumbers do

  def generate(n) when is_integer(n) and n >= 1 do
    Stream.unfold({2, 1}, fn {n1, n2} -> {n1, {n2, n1 + n2}} end)
    |> Enum.take(n)
  end
  
  def generate(_),
    do: raise(ArgumentError, "count must be specified as an integer >= 1")
    
end
