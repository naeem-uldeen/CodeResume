defmodule Wordy do

  def answer(problem) do
    problem
    |> String.trim_trailing("?")
    |> String.replace_prefix("What is", "")
    |> String.trim()
    |> tokenize([])
    |> evaluate()
  end

  defp tokenize("", acc), do: Enum.reverse(acc)
  defp tokenize(" " <> rest, acc), do: tokenize(rest, acc)
  defp tokenize("plus" <> rest, acc), do: tokenize(rest, [:plus | acc])
  defp tokenize("minus" <> rest, acc), do: tokenize(rest, [:minus | acc])
  defp tokenize("multiplied by" <> rest, acc), do: tokenize(rest, [:multiply | acc])
  defp tokenize("divided by" <> rest, acc), do: tokenize(rest, [:divide | acc])
  defp tokenize(str, acc) do
    case Integer.parse(str) do
      {n, rest} -> tokenize(rest, [n | acc])
      :error -> raise ArgumentError, "syntax error: #{inspect(str)}"
    end
  end

  defp evaluate([n | rest]) when is_integer(n), do: evaluate(rest, n)
  defp evaluate([]), do: raise(ArgumentError, "syntax error: empty expression")
  defp evaluate(_), do: raise(ArgumentError, "syntax error: expected number")
  defp evaluate([], acc), do: acc
  defp evaluate([op | rest], acc) when op in [:plus, :minus, :multiply, :divide],
    do: apply_op(rest, acc, op)
  defp evaluate([_ | _], _acc),
    do: raise(ArgumentError, "syntax error: expected operator or end")

  defp apply_op([n | rest], acc, :plus) when is_integer(n), do: evaluate(rest, acc + n)
  defp apply_op([n | rest], acc, :minus) when is_integer(n), do: evaluate(rest, acc - n)
  defp apply_op([n | rest], acc, :multiply) when is_integer(n), do: evaluate(rest, acc * n)
  defp apply_op([n | rest], acc, :divide) when is_integer(n), do: evaluate(rest, div(acc, n))
  defp apply_op([], _acc, _op), do: raise(ArgumentError, "syntax error: missing operand")
  defp apply_op([_ | _], _acc, _op), do: raise(ArgumentError, "syntax error: expected number after operator")
  
end
