defmodule ComplexNumbers do
  @typedoc """
  A complex number consisting of a real part `a` and an imaginary part `b`.

  Math defines `z = a + b*i` with `i` being the imaginary unit satisfying `i^2 = -1`.
  """
  @type complex :: {a :: number, b :: number}

  @spec real(z :: complex) :: number
  def real({a, _}), do: a

  @spec imaginary(z :: complex) :: number
  def imaginary({_, b}), do: b

  @spec add(z1 :: complex, z2 :: complex) :: complex
  @spec add(z :: complex, r :: number) :: complex
  @spec add(r :: number, z :: complex) :: complex
  def add({a, b}, {c, d}), do: {a + c, b + d}
  def add({a, b}, r) when is_number(r), do: {a + r, b}
  def add(r, {a, b}) when is_number(r), do: {a + r, b}

  @spec sub(z1 :: complex, z2 :: complex) :: complex
  @spec sub(z :: complex, r :: number) :: complex
  @spec sub(r :: number, z :: complex) :: complex
  def sub({a, b}, {c, d}), do: {a - c, b - d}
  def sub({a, b}, r) when is_number(r), do: {a - r, b}
  def sub(r, {a, b}) when is_number(r), do: {r - a, -b}

  @spec mul(z1 :: complex, z2 :: complex) :: complex
  @spec mul(z :: complex, r :: number) :: complex
  @spec mul(r :: number, z :: complex) :: complex
  def mul({a, b}, {c, d}), do: {a * c - b * d, a * d + b * c}
  def mul({a, b}, r) when is_number(r), do: {a * r, b * r}
  def mul(r, {a, b}) when is_number(r), do: {r * a, r * b}

  @spec div(z1 :: complex, z2 :: complex) :: complex
  @spec div(z :: complex, r :: number) :: complex
  @spec div(r :: number, z :: complex) :: complex
  def div({a, b}, {c, d}), do: (c * c + d * d) |> then(&{(a * c + b * d) / &1, (b * c - a * d) / &1})
  def div({a, b}, r) when is_number(r), do: {a / r, b / r}
  def div(r, {a, b}) when is_number(r), do: (a * a + b * b) |> then(&{r * a / &1, -r * b / &1})

  @spec abs(z :: complex) :: number
  def abs({a, b}), do: :math.sqrt(a * a + b * b)

  @spec conjugate(z :: complex) :: complex
  def conjugate({a, b}), do: {a, -b}

  @spec exp(z :: complex) :: complex
  def exp({a, b}), do: :math.exp(a) |> then(&{&1 * :math.cos(b), &1 * :math.sin(b)})
  
end
