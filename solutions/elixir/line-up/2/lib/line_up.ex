defmodule LineUp do

  @message_start "you are the "
  @message_end " customer we serve today. Thank you!"

  defp suffix(n)
    when rem(n, 100) in [11, 12, 13],
    do: "th"

  defp suffix(n) do
    case rem(n, 10) do
      1 -> "st"
      2 -> "nd"
      3 -> "rd"
      _ -> "th"
    end
  end

  def format(name, number) do
    "#{name}, " <>
    "#{@message_start}#{number}#{suffix(number)}" <>
    "#{@message_end}"
  end

end
