defmodule ResistorColor do

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
  
  def code(color) when is_map_key(@colors, color) do
    @colors[color]
  end
  
end
