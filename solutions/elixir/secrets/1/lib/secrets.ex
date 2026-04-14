defmodule Secrets do

  def secret_add(number),
    do: fn param -> param + number end

  def secret_subtract(number),
    do: fn param -> param - number end

  def secret_multiply(number),
    do: fn param -> param * number end

  def secret_divide(number),
    do: fn param -> trunc(param / number) end

  def secret_and(number),
    do: fn param -> Bitwise.band(param, number) end

  def secret_xor(number),
    do: fn param -> Bitwise.bxor(param, number) end

  def secret_combine(func_a, func_b),
    do: fn param -> func_b.(func_a.(param)) end

end
