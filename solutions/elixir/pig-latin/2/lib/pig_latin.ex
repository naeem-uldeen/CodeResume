defmodule PigLatin do

  @vowels ~c"aeiouAEIOU"

  def translate(phrase) do
    phrase
    |> String.split(" ")
    |> Enum.map(&do_translate/1)
    |> Enum.join(" ")
  end

  defp do_translate(<<h, _::binary>> = word)     when h in @vowels, do: word <> "ay"
  defp do_translate(<<?y, h, _::binary>> = word) when h not in @vowels, do: word <> "ay"
  defp do_translate(<<?x, ?r, _::binary>> = word), do: word <> "ay"
  defp do_translate(<<?t, ?h, ?r, t::binary>>),    do: t <> "thr" <> "ay"
  defp do_translate(<<?s, ?c, ?h, t::binary>>),    do: t <> "sch" <> "ay"
  defp do_translate(<<?s, ?q, ?u, t::binary>>),    do: t <> "squ" <> "ay"
  defp do_translate(<<?t, ?h, t::binary>>),        do: t <> "th" <> "ay"
  defp do_translate(<<?c, ?h, t::binary>>),        do: t <> "ch" <> "ay"
  defp do_translate(<<?q, ?u, t::binary>>),        do: t <> "qu" <> "ay"
  defp do_translate(word) do
    case split_at_y(word, "") do
      {consonants, rest} -> rest <> consonants <> "ay"
      :no_match ->
        <<h, t::binary>> = word
        t <> <<h>> <> "ay"
    end
  end

  defp split_at_y(<<?y, rest::binary>>, acc) when byte_size(acc) > 0, do: {acc, "y" <> rest}
  defp split_at_y(<<h, t::binary>>, acc) when h not in @vowels and h != ?y, do: split_at_y(t, acc <> <<h>>)
  defp split_at_y(_, _), do: :no_match

end
