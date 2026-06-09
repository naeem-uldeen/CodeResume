defmodule Change do

  @spec generate(list, integer) :: {:ok, list} | {:error, String.t()}
  def generate(coin_values, amount) do
    Task.async(fn -> fewest_coins(amount, Enum.sort(coin_values, :desc)) end)
    |> Task.await()
    |> case do
      {_, coins} -> {:ok, Enum.sort(coins)}
      nil        -> {:error, "cannot change"}
    end
  end

  defp fewest_coins(0, _), do: {0, []}
  defp fewest_coins(amount, _) when amount < 0, do: nil
  defp fewest_coins(amount, coin_values) do
    case Process.get(amount) do
      nil ->
        coin_values
        |> Enum.drop_while(&(&1 > amount))
        |> Enum.reduce(nil, fn
          ^amount, _     -> {1, [amount]}
          coin,   fewest -> fewer(fewest, fewest_coins(amount - coin, coin_values), coin)
        end)
        |> tap(&Process.put(amount, &1))

      cached -> cached
    end
  end

  defp fewer(fewest, nil, _), do: fewest
  defp fewer(nil, {rc, rest}, coin), do: {rc + 1, [coin | rest]}
  defp fewer({fc, _} = fewest, {rc, _}, _) when fc <= rc + 1, do: fewest
  defp fewer(_, {rc, rest}, coin), do: {rc + 1, [coin | rest]}
  
end

