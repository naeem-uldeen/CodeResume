defmodule TopSecret do

  def to_ast(str), do: str|> Code.string_to_quoted!()|> ast()

  defp ast(nil), do: {:__block__, [], []}
  defp ast(ast), do: ast

  def decode_secret_message_part({op, _, [{:when, _, [{name, _, args} | _]}, _]} = ast, acc)
    when op in [:def, :defp], do: {ast, [secret_part(name, args) | acc]}
  def decode_secret_message_part({op, _, [{name, _, params}, _]} = ast, acc)
    when op in [:def, :defp], do: {ast, [secret_part(name, params) | acc]}
  def decode_secret_message_part(ast, acc), do: {ast, acc}
  def decode_secret_message(str) do
    str
    |> to_ast()
    |> Macro.prewalk([], &decode_secret_message_part/2)
    |> elem(1)
    |> Enum.reverse()
    |> Enum.join()
  end

  defp secret_part(name, args), do: String.slice(to_string(name), 0, arity(args))

  defp arity(nil), do: 0
  defp arity(args), do: length(args)

end
