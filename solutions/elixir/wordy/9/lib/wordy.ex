defmodule Wordy do

  def answer(q) do
    case eval(q, nil) do
      result when is_integer(result) -> result
      _                              -> raise ArgumentError
    end
  end

  defp eval("What is " <> rest, nil) do
    with {result, rest} <- Integer.parse(rest), do: eval(rest, result)
  end

  defp eval("?",                    result)  when is_integer(result), do: result
  defp eval(" plus "          <> rest, op_a) when is_integer(op_a),   do: with {op_b, rest} <- Integer.parse(rest), do: eval(rest, op_a + op_b)
  defp eval(" minus "         <> rest, op_a) when is_integer(op_a),   do: with {op_b, rest} <- Integer.parse(rest), do: eval(rest, op_a - op_b)
  defp eval(" multiplied by " <> rest, op_a) when is_integer(op_a),   do: with {op_b, rest} <- Integer.parse(rest), do: eval(rest, op_a * op_b)
  defp eval(" divided by "    <> rest, op_a) when is_integer(op_a),   do: with {op_b, rest} <- Integer.parse(rest), do: eval(rest, div(op_a, op_b))
  defp eval(_, _), do: :error

end
