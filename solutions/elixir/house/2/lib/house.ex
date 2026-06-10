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
    recite_verses(1, start_verse, end_verse, @character_actions, @base, [])
  end

  defp recite_verses(current, _start, stop, _, _, acc) when current > stop do
    (Enum.reverse(acc) |> Enum.join("\n")) <> "\n"
  end

  defp recite_verses(current, start, stop, [{subject, action} | rest], core, acc) when current < start do
    recite_verses(current + 1, start, stop, rest, "the #{subject} that #{action} #{core}", acc)
  end

  defp recite_verses(current, start, stop, [{subject, action} | rest], core, acc) do
    next_core = "the #{subject} that #{action} #{core}"
    recite_verses(current + 1, start, stop, rest, next_core, ["This is " <> core | acc])
  end

  defp recite_verses(current, start, stop, [], core, acc) do
    recite_verses(current + 1, start, stop, [], core, ["This is " <> core | acc])
  end
  
end
