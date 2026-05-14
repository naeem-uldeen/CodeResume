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

  defp eval("?",                    result)    when is_integer(result), do: result
  defp eval(" plus "          <> rest, result) when is_integer(result), do: (with {op_b, rest} <- Integer.parse(rest), do: eval(rest, result + op_b))
  defp eval(" minus "         <> rest, result) when is_integer(result), do: (with {op_b, rest} <- Integer.parse(rest), do: eval(rest, result - op_b))
  defp eval(" multiplied by " <> rest, result) when is_integer(result), do: (with {op_b, rest} <- Integer.parse(rest), do: eval(rest, result * op_b))
  defp eval(" divided by "    <> rest, result) when is_integer(result), do: (with {op_b, rest} <- Integer.parse(rest), do: eval(rest, div(result, op_b)))
  defp eval(_, _),   do: :error

end
