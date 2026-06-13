defmodule House do

  @cast [
    {"house", "Jack built"},
    {"malt", "lay in"},
    {"rat", "ate"},
    {"cat", "killed"},
    {"dog", "worried"},
    {"cow with the crumpled horn", "tossed"},
    {"maiden all forlorn", "milked"},
    {"man all tattered and torn", "kissed"},
    {"priest all shaven and shorn", "married"},
    {"rooster that crowed in the morn", "woke"},
    {"farmer sowing his corn", "kept"},
    {"horse and the hound and the horn", "belonged to"},
  ]

  def recite(first, last),
    do: IO.iodata_to_binary(build_verses([], first, last))

  defp build_verses(poem, start, first_verse)
       when first_verse == start,
    do:
      poem
      |> end_verse()
      |> build_verse(first_verse, @cast)
      
  defp build_verses(poem, start, current_verse),
    do:
      poem
      |> end_verse()
      |> build_verse(current_verse, @cast)
      |> build_verses(start, current_verse - 1)

  defp build_verse(poem, 0, _), do: ["This is" | poem]
  defp build_verse(poem, n, [{actor, action} | cast]),
    do: build_verse([" the " <> actor <> " that " <> action | poem], n - 1, cast)

  defp end_verse(poem), do: [".\n" | poem]

end
