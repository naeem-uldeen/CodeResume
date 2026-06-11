defmodule Proverb do

  def recite([]), do: ""
  def recite([first | _] = strings) do
    []
    |> prepend_line("And all for the want of a " <> first <> ".")
    |> prepend_verses(reversed_pairs([], strings))
    |> IO.iodata_to_binary()
  end

  defp reversed_pairs(pairs, [_]), do: pairs
  defp reversed_pairs(pairs, [a, b | rest]),
    do: reversed_pairs([{a, b} | pairs], [b | rest])

  defp prepend_verses(acc, []), do: acc
  defp prepend_verses(acc, [{cause, effect} | rest]),
    do: acc
    |> prepend_line("For want of a " <> cause <> " the " <> effect <> " was lost.")
    |> prepend_verses(rest)

  defp prepend_line(acc, text), do: [text <> "\n" | acc]
  
end
