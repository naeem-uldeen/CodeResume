defmodule ResistorColorDuo do

  @colors_with_digits Enum.with_index(
    [:black,
     :brown,
     :red,
     :orange,
     :yellow,
     :green,
     :blue,
     :violet,
     :grey,
     :white
     ]
                                       )
    # Nested comprehension: generates function clauses for ALL 100 combinations
    # (10 colors × 10 colors = 100 clauses)
    for {color1, digit1} <- @colors_with_digits,
        {color2, digit2} <- @colors_with_digits do
    # unquote injects the actual color atom (e.g., :black) into the function head
    # unquote injects the actual digit (e.g., 0) into the function body
    def value([unquote(color1), unquote(color2) | _]) do
      unquote(digit1) * 10 + unquote(digit2)
    end
  end

end
