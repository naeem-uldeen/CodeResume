defmodule ResistorColorDuo do

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
  
  def value([color_1, color_2 | _]), 
    do: 
      @digits_by_color[color_1] * 10 +
      @digits_by_color[color_2]
    
end
