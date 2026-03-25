defmodule LineUp do

  def suffix(number) do
    case number do
      n when rem(n, 100) in [11, 12, 13] -> "th"
      n when rem(n, 10) == 1 -> "st"
      n when rem(n, 10) == 2 -> "nd"
      n when rem(n, 10) == 3 -> "rd"
      _ -> "th"
    end
  end

  def format(name, number) do
    "#{name}, you are the " <>
    "#{number}#{suffix(number)} " <>
    "customer we serve today. Thank you!"
  end

end
