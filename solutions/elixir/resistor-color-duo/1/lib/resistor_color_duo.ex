defmodule ResistorColorDuo do

  @colors %{
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
  
  defp code(color) when is_map_key(@colors, color) do
    @colors[color]
  end
  
  def value([color1, color2 | _ ]) do
    code(color1) * 10 + code(color2)
  end
  
end
