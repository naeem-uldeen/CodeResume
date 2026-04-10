defmodule SumOfMultiples do

  def to(limit, [factor]) when factor > 0 do
    for multiple <- factor..limit - 1//factor, reduce: 0 do
      sum -> sum + multiple
    end
  end

  def to(limit, factors) when is_list(factors) do
    sum_multiples(limit - 1, factors, 0)
  end

  defp sum_multiples(0, _factors, sum), do: sum

  defp sum_multiples(current, factors, sum) do
    if multiple?(current, factors) do
      sum_multiples(current - 1, factors, sum + current)
    else
      sum_multiples(current - 1, factors, sum)
    end
  end

  defp multiple?(number, factors) do
    Enum.any?(factors, &(&1 != 0 && rem(number, &1) == 0))
  end
  
end
