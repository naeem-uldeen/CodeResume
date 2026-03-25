defmodule SquareRoot do

  def calculate(radicand) when radicand < 0 do
    raise ArgumentError, "Enter a postive integer"
  end

  def calculate(0), do: 0
  def calculate(1), do: 1

  def calculate(radicand) when is_integer(radicand) do
    radicand
    |> newtons_method()
  end

  defp newtons_method(radicand) do
    guess = div(radicand, 2)
    iterate(radicand, guess)
  end

  defp iterate(radicand, guess) do
    new_guess = div(guess + div(radicand, guess), 2)
    if new_guess >= guess do
      guess
    else
      iterate(radicand, new_guess)
    end
  end

end

