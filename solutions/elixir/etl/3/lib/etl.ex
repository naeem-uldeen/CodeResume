defmodule ETL do

  def transform(letter_scores = %{}),
    do: for({score, letters} <- letter_scores, letter <- letters,
    into: %{}, do: {String.downcase(letter), score})
      
end
