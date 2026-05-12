defmodule Wordy do

  def answer("What is " <> rest) do
    tokens = tokenize(String.trim_trailing(rest, "?"))
    evaluate(tokens)
  end
  def answer(_), do: raise ArgumentError

  defp tokenize(question),                   do: tokenize(String.split(question), [])
  defp tokenize(["plus" | rest], operator),  do: tokenize(rest, [:plus | operator])
  defp tokenize(["minus" | rest], operator), do: tokenize(rest, [:minus | operator])
  defp tokenize(["multiplied", "by" | rest], operator),
                                             do: tokenize(rest, [:multiplied | operator])
  defp tokenize(["divided", "by" | rest], operator),
                                             do: tokenize(rest, [:divided | operator])
  defp tokenize([], operator),               do: Enum.reverse(operator)
  defp tokenize([digit | rest], operator) do
    case Integer.parse(digit) do
      {digit, ""} -> tokenize(rest, [digit | operator])
      _ -> raise ArgumentError
    end
  end

  defp evaluate([digit | rest])
    when is_integer(digit),  do: evaluate(digit, rest)
  defp evaluate(_),          do: raise ArgumentError
  defp evaluate(answer, []), do: answer
  defp evaluate(answer, [operator, digit | rest])
    when is_integer(digit),  do: evaluate(apply_operator(answer, operator, digit), rest)
  defp evaluate(_, _),       do: raise ArgumentError

  defp apply_operator(a, :plus, b),       do: a + b
  defp apply_operator(a, :minus, b),      do: a - b
  defp apply_operator(a, :multiplied, b), do: a * b
  defp apply_operator(a, :divided, b),    do: div(a, b)
  defp apply_operator(_, _, _),           do: raise ArgumentError

end
