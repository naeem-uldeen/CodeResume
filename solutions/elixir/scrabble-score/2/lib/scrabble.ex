defmodule Scrabble do

  @letter_scores %{
    1  => ~w(a e i o u l n r s t),
    2  => ~w(d g),
    3  => ~w(b c m p),
    4  => ~w(f h v w y),
    5  => ~w(k),
    8  => ~w(j x),
    10 => ~w(q z)
  }

  def score(word) do
    for <<letter <- word>>, reduce: 0 do
      acc -> acc + letter_score(if letter in ?A..?Z,
        do: letter + 32, else: letter)
    end
  end

  for {score, letters} <- @letter_scores, letter <- letters do
    [char] = String.to_charlist(letter)
    defp letter_score(unquote(char)), do: unquote(score)
  end
  defp letter_score(_), do: 0

end
