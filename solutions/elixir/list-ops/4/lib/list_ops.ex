defmodule ListOps do

  def foldl([], acc, _), do: acc
  def foldl([h | t], acc, f), do: foldl(t, f.(h, acc), f)

  def count(l), do: foldl(l, 0, fn _, acc -> acc + 1 end)
  def reverse(l), do: foldl(l, [], &[&1 | &2])

  def map(l, f), do: reverse(foldl(l, [], &[f.(&1) | &2]))

  def filter(l, f), do: reverse(foldl(l, [], &(if f.(&1), do: [&1 | &2], else: &2)))

  def foldr(l, acc, f), do: foldl(reverse(l), acc, f)

  def append([], b), do: b
  def append(a, []), do: a
  def append(a, b), do: foldl(reverse(a), b, &[&1 | &2])

  def concat(ll), do: foldr(ll, [], &append/2)
  
end