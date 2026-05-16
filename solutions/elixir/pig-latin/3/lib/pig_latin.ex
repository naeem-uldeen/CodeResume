defmodule PigLatin do

  @vowels     ~c"aeiouAEIOU"
  @consonants (Enum.to_list(?a..?z) ++ Enum.to_list(?A..?Z)) -- @vowels

  def translate(phrase) do
    String.split(phrase, " ")
    |> Enum.map_join(" ", &to_pig_latin/1)
  end

  defp to_pig_latin(<<vwl, _::binary>> = word)      when vwl in @vowels,      do: word <> "ay"
  defp to_pig_latin(<<?y, ltr, _::binary>> = word)  when ltr in @consonants,  do: word <> "ay"
  defp to_pig_latin(<<?x, ?r, _::binary>> = word),                            do: word <> "ay"
  defp to_pig_latin(<<?t, ?h, ?r, clstr::binary>>),  do: clstr <> "thr" <> "ay"
  defp to_pig_latin(<<?s, ?c, ?h, clstr::binary>>),  do: clstr <> "sch" <> "ay"
  defp to_pig_latin(<<?s, ?q, ?u, clstr::binary>>),  do: clstr <> "squ" <> "ay"
  defp to_pig_latin(<<?t, ?h, clstr::binary>>),      do: clstr <> "th"  <> "ay"
  defp to_pig_latin(<<?c, ?h, clstr::binary>>),      do: clstr <> "ch"  <> "ay"
  defp to_pig_latin(<<?q, ?u, clstr::binary>>),      do: clstr <> "qu"  <> "ay"
  defp to_pig_latin(word) do
    case split_at_y(word, "") do
      {cnsnt_clstr, clstr} -> clstr <> cnsnt_clstr <> "ay"
      :no_match ->
        <<cnsnt, clstr::binary>> = word
        clstr <> <<cnsnt>> <> "ay"
    end
  end

  defp split_at_y(<<?y, rest::binary>>, cnsnt_clstr)    when byte_size(cnsnt_clstr) > 0,
    do: {cnsnt_clstr, "y" <> rest}
  defp split_at_y(<<cnsnt, rest::binary>>, cnsnt_clstr) when cnsnt in @consonants and cnsnt != ?y,
    do: split_at_y(rest, cnsnt_clstr <> <<cnsnt>>)
  defp split_at_y(_, _), do: :no_match

end
