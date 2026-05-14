defmodule Wordy do

  def answer(q) do
    case eval(q, nil) do
      {res, ""} when is_integer(res) -> res
      _                              -> raise ArgumentError
    end
  end

  def eval("What is " <> t, nil),    do: (with {op_b, t} <- integer(t), do: eval(t, op_b))
  def eval(_, nil),                  do: :error
  def eval("?", op_a) when is_integer(op_a), do: {op_a, ""}
  def eval(" plus "         <> t, op_a) when is_integer(op_a),  do: (with {op_b, t} <- integer(t), do: eval(t, op_a + op_b))
  def eval(" minus "        <> t, op_a) when is_integer(op_a),  do: (with {op_b, t} <- integer(t), do: eval(t, op_a - op_b))
  def eval(" multiplied by " <> t, op_a) when is_integer(op_a), do: (with {op_b, t} <- integer(t), do: eval(t, op_a * op_b))
  def eval(" divided by "   <> t, op_a) when is_integer(op_a),  do: (with {op_b, t} <- integer(t), do: eval(t, div(op_a, op_b)))
  def eval(_, _), do: :error

  defp integer("-" <> t), do: (with {h, t} <- digits(t), do: {-String.to_integer(h), t})
  defp integer(t),        do: (with {h, t} <- digits(t), do: { String.to_integer(h), t})

  defp digits(<<c, _::binary>> = h) when c in ?0..?9, do: digits(h, "")
  defp digits(_),                                     do: :error
  defp digits(<<c, t::binary>>, h) when c in ?0..?9,  do: digits(t, h <> <<c>>)
  defp digits(t, h),                                  do: {h, t}

end
