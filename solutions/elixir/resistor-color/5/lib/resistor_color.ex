defmodule ResistorColor do

  colors_with_digits = Enum.with_index([
    :black,
    :brown,
    :red,
    :orange,
    :yellow,
    :green,
    :blue,
    :violet,
    :grey,
    :white
  ])

  for {color, digit} <- colors_with_digits,
    do: def(code(unquote(color)), do: unquote(digit))

end
