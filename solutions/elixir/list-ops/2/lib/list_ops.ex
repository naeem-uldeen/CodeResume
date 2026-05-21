defmodule ListOps do

  def count(list),
    do: foldl(list, 0, fn _head, acc -> acc + 1 end)

  def reverse(list),
    do: foldl(list, [], fn head, acc -> [head | acc] end)

  def map(list, fun) do
    list
    |> foldl([], fn head, acc -> [fun.(head) | acc] end)
    |> reverse()
  end

  def filter(list, fun) do
    list
    |> foldl([], fn head, acc ->
      if fun.(head), do: [head | acc], else: acc end)
    |> reverse()
  end

  def foldl([], acc, _fun), do: acc
  def foldl([head | tail], acc, fun),
    do: foldl(tail, fun.(head, acc), fun)

  def foldr(list, acc, fun) do
    list
    |> reverse()
    |> foldl(acc, fun)
  end

  def append(list_a, list_b) do
    list_a
    |> reverse()
    |> foldl(list_b, fn head, acc -> [head | acc] end)
  end

  def concat(list) do
    list
    |> reverse()
    |> foldl([], &append/2)
  end

end

