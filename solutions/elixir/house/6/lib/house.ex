defmodule House do

  @cast [
    {"house that Jack built.", ""},
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
      do:
        []
        |> build_verses(first, last)
        |> IO.iodata_to_binary()

  defp build_verses(poem, start, current) when start == current,
    do: poem |> newline() |> build_verse(current, @cast)
  defp build_verses(poem, start, current),
    do: poem |> newline() |> build_verse(current, @cast) |> build_verses(start, current - 1)
  defp build_verse(poem, 0, _), do: ["This is" | poem]
  defp build_verse(poem, n, [{actor, ""} | cast]),
    do: [" the " <> actor | poem] |> build_verse(n - 1, cast)
  defp build_verse(poem, n, [{actor, action} | cast]),
    do: [" the " <> actor <> " that " <> action | poem] |> build_verse(n - 1, cast)
  defp newline(poem), do: ["\n" | poem]
  
end
