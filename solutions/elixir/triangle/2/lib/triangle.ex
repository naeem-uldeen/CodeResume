defmodule Triangle do

  @type kind :: :equilateral | :isosceles | :scalene

  @spec kind(number, number, number) :: {:ok, kind} | {:error, String.t()}
  def kind(a, b, c) when a <= 0 or b <= 0 or c <= 0,
    do: {:error, "all side lengths must be positive"}
  def kind(a, b, c) when a + b <= c or b + c <= a or a + c <= b,
    do: {:error, "side lengths violate triangle inequality"}
  def kind(s, s, s),  do: {:ok, :equilateral}
  def kind(s, s, _),  do: {:ok, :isosceles}
  def kind(_, s, s),  do: {:ok, :isosceles}
  def kind(s, _, s),  do: {:ok, :isosceles}
  def kind(_, _, _),  do: {:ok, :scalene}

end
