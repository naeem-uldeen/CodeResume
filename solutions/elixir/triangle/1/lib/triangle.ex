defmodule Triangle do

  @type kind :: :equilateral | :isosceles |:scalene

  @spec kind(number, number, number) :: {:ok, kind} | {:error, String.t()}
  def kind(a, b, c), do: do_kind({a, b, c})

  defp do_kind({a, b, c}) when a <= 0 or b <= 0 or c <= 0,
    do: {:error, "all side lengths must be positive"}
  defp do_kind({a, b, c}) when a + b <= c or b + c <= a or a + c <= b,
    do: {:error, "side lengths violate triangle inequality"}
  defp do_kind({a, a, a}),  do: {:ok, :equilateral}
  defp do_kind({a, a, _c}), do: {:ok, :isosceles}
  defp do_kind({_a, b, b}), do: {:ok, :isosceles}
  defp do_kind({a, _b, a}), do: {:ok, :isosceles}
  defp do_kind(_),          do: {:ok, :scalene}

end
