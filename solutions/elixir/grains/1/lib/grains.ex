defmodule Grains do
  use Bitwise

  def square(n) when n < 1 or n > 64,
    do: {:error, "The requested square must be between 1 and 64 (inclusive)"}
  def square(n), do: {:ok, 1 <<< (n - 1)}
  def total,     do: {:ok, (1 <<< 64) - 1}
  
end
