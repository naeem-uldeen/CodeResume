defmodule ResistorColorTrio do

  colors_with_digits = Enum.with_index([
    :black, :brown, :red, :orange, :yellow,
    :green, :blue, :violet, :grey, :white
  ])

  for {color, digit} <- colors_with_digits do
    defp multiplier([_, _, unquote(color) | _]), do: unquote(round(:math.pow(10, digit)))
  end

  defp unit(ohms) when ohms >= 1_000_000_000, do: {div(ohms, 1_000_000_000), :gigaohms}
  defp unit(ohms) when ohms >= 1_000_000,     do: {div(ohms, 1_000_000),     :megaohms}
  defp unit(ohms) when ohms >= 1_000,         do: {div(ohms, 1_000),         :kiloohms}
  defp unit(ohms),                            do: {ohms,                     :ohms}

  def label(colors), do: unit((ResistorColorDuo.value(colors) * multiplier(colors)))

end

defmodule ResistorColorDuo do

  colors_with_digits = Enum.with_index([
    :black, :brown, :red, :orange, :yellow,
    :green, :blue, :violet, :grey, :white
  ])

  for {color1, digit1} <- colors_with_digits,
      {color2, digit2} <- colors_with_digits do
    def value([unquote(color1), unquote(color2) | _]) do
      unquote(digit1 * 10 + digit2)
    end
  end

end
