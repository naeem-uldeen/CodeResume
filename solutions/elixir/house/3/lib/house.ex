defmodule House do

  @base "the house that Jack built."
  @character_actions [
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

  def recite(start_verse, end_verse) do
    {skip, collect} = Enum.split(@character_actions, start_verse - 1)
    recite_verses(end_verse - start_verse + 1, collect, build_core(skip, @base), [])
  end

  defp recite_verses(0, _, _, acc), do: (Enum.reverse(acc) |> Enum.join("\n")) <> "\n"
  defp recite_verses(n, [], core, acc), do: recite_verses(n - 1, [], core, ["This is " <> core | acc])
  defp recite_verses(n, [{subject, action} | rest], core, acc) do
    next_core = "the #{subject} that #{action} #{core}"
    recite_verses(n - 1, rest, next_core, ["This is " <> core | acc])
  end

  defp build_core([], poem), do: poem
  defp build_core([{subject, action} | rest], poem),
    do: build_core(rest, "the #{subject} that #{action} #{poem}")

end
