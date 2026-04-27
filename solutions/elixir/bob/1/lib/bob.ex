defmodule Bob do

  def hey(remark) do
    trimmed = String.trim(remark)

    question? = trimmed
    |> String.trim_trailing()
    |> String.ends_with?("?")

    yelling? = trimmed != "" and
      String.upcase(trimmed) == trimmed and
      String.downcase(trimmed) != trimmed

    response(trimmed, yelling?, question?)
  end

  defp response(_trimmed, true, true),
    do: "Calm down, I know what I'm doing!"
  defp response(trimmed, _yelling, _question) when trimmed == "",
    do: "Fine. Be that way!"
  defp response(_trimmed, true, _question),
    do: "Whoa, chill out!"
  defp response(_trimmed, _yelling, true),
    do: "Sure."
  defp response(_trimmed, _yelling, _question),
    do: "Whatever."

end
