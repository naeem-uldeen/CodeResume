defmodule TopSecret do

  def decode_secret_message(source_code),
    do:
      source_code
      |> message_parts()
      |> IO.iodata_to_binary()

  defp message_parts(source_code) do
    source_code
    |> to_ast()
    |> Macro.prewalk([], &decode_secret_message_part/2)
    |> elem(1)
    |> Enum.reverse()
  end

  def to_ast(source_code), do: Code.string_to_quoted!(source_code)

  def decode_secret_message_part(
        {op, _, [{:when, _, [{name, _, args} | _]}, _]} = ast,
        message_parts
      )
      when op in [:def, :defp],
      do: {ast, [message_part(name, args) | message_parts]}

  def decode_secret_message_part({op, _, [{name, _, args}, _]} = ast, message_parts)
      when op in [:def, :defp],
      do: {ast, [message_part(name, args) | message_parts]}

  def decode_secret_message_part(ast, message_parts), do: {ast, message_parts}

  defp message_part(_name, nil), do: ""
  defp message_part(name, args), do: String.slice(to_string(name), 0, length(args))
  
end
