defmodule Prime do

  @type count :: pos_integer()
  @max_count 1_000_000

  def nth(count) when not is_integer(count),
    do: raise(ArgumentError, "count must be an integer, got: #{inspect(count)}")
  def nth(count) when count < 1,
    do: raise(ArgumentError, "there is no zeroth prime")
  def nth(count) when count > @max_count,
    do: raise(ArgumentError, "count exceeds maximum supported value of #{@max_count}")
  def nth(1), do: 2
  def nth(count) do
    case PrimeCache.get(count) do
      {:ok, prime} ->
        prime
      :miss ->
        prime = find_nth(3, 1, count)
        PrimeCache.put(count, prime)
        prime
    end
  end

  defp find_nth(candidate, found, target) do
    if PrimeCheck.prime?(candidate) do
      if found + 1 == target do
        candidate
      else
        find_nth(candidate + 2, found + 1, target)
      end
    else
      find_nth(candidate + 2, found, target)
    end
  end
end


defmodule PrimeCheck do

  def prime?(n) when not is_integer(n),
    do: raise(ArgumentError, "argument must be an integer, got: #{inspect(n)}")
  def prime?(n) when n < 2, do: false
  def prime?(2), do: true
  def prime?(3), do: true
  def prime?(n) when rem(n, 2) == 0 or rem(n, 3) == 0, do: false
  def prime?(n) do
    limit = floor(:math.sqrt(n))
    prime?(n, 5, limit)
  end
  defp prime?(_n, current, limit) when current > limit, do: true
  defp prime?(n, current, _limit)
       when rem(n, current) == 0 or rem(n, current + 2) == 0,
       do: false
  defp prime?(n, current, limit), do: prime?(n, current + 6, limit)

end


defmodule PrimeCache do

  def get(n) do
    ensure_table()

    case :ets.lookup(@table, n) do
      [{^n, prime}] -> {:ok, prime}
      [] -> :miss
    end
  end

  def put(n, prime) do
    ensure_table()
    :ets.insert(@table, {n, prime})
    :ok
  end

  def clear do
    ensure_table()
    :ets.delete_all_objects(@table)
    :ok
  end

  defp ensure_table do
    if :ets.whereis(@table) == :undefined do
      :ets.new(@table, [:set, :public, :named_table])
    end
  end

end
