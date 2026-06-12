defmodule Proverb do

  def recite([]), do: ""
  def recite([wanted | _] = items),
    do: IO.iodata_to_binary(recite_verses([], items, wanted))

  defp recite_verses(phrases, [_], wanted),
    do: [phrases, "And all for the want of a ", wanted, ".\n"]
  defp recite_verses(phrases, [cause, effect | rest], wanted),
    do: recite_verses(
      [phrases, "For want of a ", cause, " the ", effect, " was lost.\n"],
      [effect | rest],
      wanted
    )

end
