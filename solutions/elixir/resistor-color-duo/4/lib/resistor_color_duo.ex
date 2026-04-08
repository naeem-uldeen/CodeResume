defmodule ResistorColorDuo do

  @colors_with_digits Enum.with_index([
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

  for {color1, digit1} <- @colors_with_digits,
      {color2, digit2} <- @colors_with_digits do
    def value([unquote(color1), unquote(color2) | _]) do
      unquote(digit1) * 10 + unquote(digit2)
    end
  end

end
