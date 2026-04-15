defmodule Secrets do

  def secret_add(arg) when is_integer(arg),
    do: &Kernel.+(&1, arg)

  def secret_subtract(arg) when is_integer(arg),
    do: &Kernel.-(&1, arg)

  def secret_multiply(arg) when is_integer(arg),
    do: &Kernel.*(&1, arg)

  def secret_divide(arg) when is_integer(arg) and arg != 0,
    do: fn n -> trunc(n / arg) end

  def secret_and(arg) when is_integer(arg),
    do: &Bitwise.band(&1, arg)

  def secret_xor(arg) when is_integer(arg),
    do: &Bitwise.bxor(&1, arg)

  def secret_combine(f1, f2) when is_function(f1, 1) and is_function(f2, 1),
    do: fn arg -> f2.(f1.(arg)) end
end
