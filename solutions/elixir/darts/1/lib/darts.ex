defmodule Darts do

  def score({x, y}) do
    radius = :math.sqrt(x*x + y*y)
    case radius do
      r when r <= 1.0 -> 10
      r when r <= 5.0 -> 5
      r when r <= 10.0 -> 1
      _ -> 0
    end
  end
  
end
