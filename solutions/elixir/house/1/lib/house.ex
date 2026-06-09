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
    recite_verses(start_verse, end_verse, [])
  end

  defp recite_verses(current, stop, acc) when current > stop do
    (Enum.reverse(acc) |> Enum.join("\n")) <> "\n"
  end

  defp recite_verses(current, stop, acc) do
    recite_verses(current + 1, stop, [build_verse(current) | acc])
  end

  defp build_verse(n) do
    "This is " <> verse(Enum.take(@character_actions, n - 1), @base)
  end

  defp verse([], poem) do
    poem
  end

  defp verse([{subject, action} | rest], poem) do
    verse(rest, "the #{subject} that #{action} #{poem}")
  end
  
end
