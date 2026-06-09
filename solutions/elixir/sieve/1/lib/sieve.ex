defmodule Sieve do

  def primes_to(limit) when limit < 2, do: []
  def primes_to(limit) do
    Task.async(fn -> sieve(limit, 3, [2]) end)
    |> Task.await(:infinity)
  end

  defp sieve(limit, current, acc) when current > limit, do: Enum.reverse(acc)
  defp sieve(limit, current, acc), do: sieve(limit, current, acc, Process.get(current))

  defp sieve(limit, current, acc, true), do: sieve(limit, current + 2, acc)
  defp sieve(limit, current, acc, nil) do
    mark_composites(current * current, current * 2, limit)
    sieve(limit, current + 2, [current | acc])
  end

  defp mark_composites(n, _step, limit) when n > limit, do: :ok
  defp mark_composites(n, step, limit) do
    Process.put(n, true)
    mark_composites(n + step, step, limit)
  end
  
end
