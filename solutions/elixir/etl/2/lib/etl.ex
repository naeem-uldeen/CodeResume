defmodule ETL do
  @doc """
  Transforms a Scrabble scoring system from a grouping of letters by score,
  into a lookup of score by (downcased) letter.

  ## Examples

    iex> ETL.transform(%{1 => ["A", "E"], 2 => ["D", "G"]})
    %{"a" => 1, "d" => 2, "e" => 1, "g" => 2}

  """

  @spec transform(letters_by_score :: map) :: map
  def transform(letters_by_score = %{}),
    do:
      for(
        {score, letters = [letter | _]}
          when is_integer(score) and is_binary(letter) <- letters_by_score,
        letter <- letters,
        into: %{},
        do: {String.downcase(letter), score}
      )

end
