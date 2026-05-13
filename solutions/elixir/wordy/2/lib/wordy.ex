defmodule Wordy do

  def answer("What is " <> rest) do
    question = String.trim_trailing(rest, "?")
    tokens = tokenize(question)
    validate_infix!(tokens)
    digits = extract_digits(tokens)
    operators = extract_op(tokens)
    evaluate(digits, operators)
  end
  def answer(_), do: raise ArgumentError

  defp tokenize(question), do: String.split(question)

  defp validate_infix!(tokens), do: validate_infix!(tokens, :number)

  defp validate_infix!([], :number), do: raise ArgumentError
  defp validate_infix!([], :operator), do: :ok
  defp validate_infix!([token | rest], :number) do
    case Integer.parse(token) do
      {_, ""} -> validate_infix!(rest, :operator)
      _ -> raise ArgumentError
    end
  end
  defp validate_infix!(["plus" | rest], :operator), do: validate_infix!(rest, :number)
  defp validate_infix!(["minus" | rest], :operator), do: validate_infix!(rest, :number)
  defp validate_infix!(["multiplied", "by" | rest], :operator), do: validate_infix!(rest, :number)
  defp validate_infix!(["divided", "by" | rest], :operator), do: validate_infix!(rest, :number)
  defp validate_infix!(_, :operator), do: raise ArgumentError

  defp extract_digits(tokens), do: extract_digits(tokens, [])
  defp extract_digits([], digits), do: Enum.reverse(digits)
  defp extract_digits([word | rest], digits) do
    case Integer.parse(word) do
      {n, ""} -> extract_digits(rest, [n | digits])
      _       -> extract_digits(rest, digits)
    end
  end

  defp extract_op(tokens), do: extract_op(tokens, [])
  defp extract_op([], op), do: Enum.reverse(op)
  defp extract_op(["plus" | rest], op),              do: extract_op(rest, [:plus | op])
  defp extract_op(["minus" | rest], op),             do: extract_op(rest, [:minus | op])
  defp extract_op(["multiplied", "by" | rest], op),  do: extract_op(rest, [:multiplied | op])
  defp extract_op(["divided", "by" | rest], op),     do: extract_op(rest, [:divided | op])
  defp extract_op([_ | rest], op),                   do: extract_op(rest, op)

  defp evaluate([], _), do: raise ArgumentError
  defp evaluate([digit | rest], operators)
    when length(rest) == length(operators), do: evaluate(digit, rest, operators)
  defp evaluate(_, _), do: raise ArgumentError
  defp evaluate(answer, [], []), do: answer
  defp evaluate(answer, [digit | digits], [op | ops]),
    do: evaluate(apply_operator(answer, op, digit), digits, ops)

  defp apply_operator(a, :plus, b),       do: a + b
  defp apply_operator(a, :minus, b),      do: a - b
  defp apply_operator(a, :multiplied, b), do: a * b
  defp apply_operator(a, :divided, b),    do: div(a, b)
  defp apply_operator(_, _, _),           do: raise ArgumentError

end
