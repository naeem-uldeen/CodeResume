defmodule ResistorColor do

  @digits_by_color %{
    black:  0,
    brown:  1,
    red:    2,
    orange: 3,
    yellow: 4,
    green:  5,
    blue:   6,
    violet: 7,
    grey:   8,
    white:  9
  }

  def code(color) when is_map_key(@digits_by_color, color),
    do: @digits_by_color[color]

end
