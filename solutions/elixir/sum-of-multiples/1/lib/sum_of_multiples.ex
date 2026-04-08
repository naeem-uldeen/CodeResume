defmodule SumOfMultiples do

  def to(limit, factors) when is_list(factors) do
    Enum.reduce(1..(limit - 1), 0, fn number, sum ->
      if multiple?(factors, number) do
        number + sum
      else
        sum
      end
    end)
  end

  defp multiple?(factors, number) do
    Enum.any?(factors, fn factor ->
      factor != 0 && rem(number, factor) == 0
    end)
  end

end
