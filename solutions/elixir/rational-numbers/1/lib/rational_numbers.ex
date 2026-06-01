defmodule RationalNumbers do
  alias Integer, as: I

  @type rational :: {integer, integer}

  @doc """
  Add two rational numbers
  """
  @spec add(a :: rational, b :: rational) :: rational
  def add({num1, den1}, {num2, den2}), do: reduce({num1 * den2 + num2 * den1, den1 * den2})

  @doc """
  Subtract two rational numbers
  """
  @spec subtract(a :: rational, b :: rational) :: rational
  def subtract({num1, den1}, {num2, den2}), do: reduce({num1 * den2 - num2 * den1, den1 * den2})

  @doc """
  Multiply two rational numbers
  """
  @spec multiply(a :: rational, b :: rational) :: rational
  def multiply({num1, den1}, {num2, den2}), do: reduce({num1 * num2, den1 * den2})

  @doc """
  Divide two rational numbers
  """
  @spec divide_by(a :: rational, b :: rational) :: rational
  def divide_by({num1, den1}, {num2, den2}), do: reduce({num1 * den2, den1 * num2})

  @doc """
  Absolute value of a rational number
  """
  @spec abs(a :: rational) :: rational
  def abs({num, den}), do: reduce({Kernel.abs(num), Kernel.abs(den)})

  @doc """
  Exponentiation of a rational number by an integer
  """
  @spec pow_rational(a :: rational, n :: integer) :: rational
  def pow_rational({num, den}, n) when n >= 0, do: reduce({I.pow(num, n), I.pow(den, n)})

  def pow_rational({num, den}, n) when n < 0 do
    m = -n;
    reduce({I.pow(den, m), I.pow(num, m)})
  end

  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(x :: integer, n :: rational) :: float
  def pow_real(x, {num, den}), do: :math.pow(x * 1.0, num / den)

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(a :: rational) :: rational
  def reduce({0, _}), do: {0, 1}

  def reduce({num, den}) do
    gcd = I.gcd(Kernel.abs(num), Kernel.abs(den))
    {div(num, gcd), div(den, gcd)}|> normalize_sign()
  end

  defp normalize_sign({num, den}) when den < 0, do: {-num, -den}
  defp normalize_sign({num, den}), do: {num, den}

end
