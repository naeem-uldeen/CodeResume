defmodule PigLatin do

  @vowels     ~c"aeiou"
  @consonants Enum.to_list(?a..?z) -- @vowels

  def translate(phrase) do
    phrase
    |> String.split(" ")
    |> Enum.map(&do_translate/1)
    |> Enum.join(" ")
  end

  defp do_translate(<<h, _::binary>> = word) when h in @vowels,            do: word <> "ay"
  defp do_translate(<<?x, ?r, _::binary>>   = word),                       do: word <> "ay"
  defp do_translate(<<?y, h,  _::binary>>   = word) when h in @consonants, do: word <> "ay"

  defp do_translate(<<?s, ?q, ?u, t::binary>>), do: t <> "squ" <> "ay"
  defp do_translate(<<?q, ?u,     t::binary>>), do: t <> "qu"  <> "ay"

  defp do_translate(word), do: strip_consonants(word, "")
  defp strip_consonants(<<?y, _::binary>> = rest, acc) when byte_size(acc) > 0,
    do: rest <> acc <> "ay"
  defp strip_consonants(<<h, _::binary>> = rest, acc) when h in @vowels,
    do: rest <> acc <> "ay"
  defp strip_consonants(<<h, t::binary>>, acc) when h in @consonants,
    do: strip_consonants(t, acc <> <<h>>)
  defp strip_consonants(rest, acc), do: rest <> acc <> "ay"

end
