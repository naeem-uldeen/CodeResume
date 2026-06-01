defmodule ComplexNumbers do

  @type complex :: {number, number}

  @spec real(a :: complex) :: number
  def real({a, _}), do: a

  @spec imaginary(a :: complex) :: number
  def imaginary({_, b}), do: b

  @spec add(a :: complex | number, b :: complex | number) :: complex
  def add({a, b}, {c, d}), do: {a + c, b + d}
  def add({a, b}, r), do: {a + r, b}
  def add(r, {a, b}), do: {r + a, b}

  @spec sub(a :: complex | number, b :: complex | number) :: complex
  def sub({a, b}, {c, d}), do: {a - c, b - d}
  def sub({a, b}, r), do: {a - r, b}
  def sub(r, {a, b}), do: {r - a, -b}

  @spec mul(a :: complex | number, b :: complex | number) :: complex
  def mul({a, b}, {c, d}), do: {a * c - b * d, a * d + b * c}
  def mul({a, b}, r), do: {a * r, b * r}
  def mul(r, {a, b}), do: {r * a, r * b}

  @spec div(a :: complex | number, b :: complex | number) :: complex
  def div({a, b}, {c, d}), do: (c * c + d * d) |> then(&{(a * c + b * d) / &1, (b * c - a * d) / &1})
  def div({a, b}, r), do: {a / r, b / r}
  def div(r, {a, b}), do: (a * a + b * b) |> then(&{r * a / &1, -r * b / &1})

  @spec abs(a :: complex) :: number
  def abs({a, b}), do: :math.sqrt(a * a + b * b)

  @spec conjugate(a :: complex) :: complex
  def conjugate({a, b}), do: {a, -b}

  @spec exp(a :: complex) :: complex
  def exp({a, b}), do: :math.exp(a) |> then(&{&1 * :math.cos(b), &1 * :math.sin(b)})
  
end
