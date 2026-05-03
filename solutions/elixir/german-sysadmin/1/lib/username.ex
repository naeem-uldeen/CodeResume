defmodule GermanSysAdmimStringUtils do

  def remove_non_lowercase_chars(user_name),
    do: Enum.flat_map(user_name, &sanitize_code_point/1)

  defp sanitize_code_point(?ü), do: [?u, ?e]
  defp sanitize_code_point(?ö), do: [?o, ?e]
  defp sanitize_code_point(?ä), do: [?a, ?e]
  defp sanitize_code_point(?ß), do: [?s, ?s]
  defp sanitize_code_point(code_point) when
    code_point >= ?a and
    code_point <= ?z or
    code_point == ?_ do [code_point]
  end
  defp sanitize_code_point(_), do: []

end

defmodule Username do
  def sanitize(user_name) do
    case user_name do
      [] -> []
      _ -> user_name
      |> GermanSysAdmimStringUtils.remove_non_lowercase_chars()
    end
  end

end
