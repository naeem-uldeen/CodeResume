defmodule House do
  @subjects_and_verbs [
    {"house", "Jack built."},
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

  def recite(start, stop),
    do: Enum.join(collect(stop, start, Enum.take(@subjects_and_verbs, stop), ["\n"]))
    
  defp collect(verse, start, _, ["\n" | parts]) when verse < start, do: parts
  defp collect(verse, start, [], parts),
    do: collect(verse - 1, start, Enum.take(@subjects_and_verbs, verse - 1), ["\n", "This is" | parts])
  defp collect(verse, start, [{s, v} | rest], parts),
    do: collect(verse, start, rest, [" the #{s} that #{v}" | parts])
  
end
