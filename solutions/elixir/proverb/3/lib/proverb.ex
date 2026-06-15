defmodule Proverb do

  def recite([]), do: ""
  def recite([wanted | _] = items),
    do: IO.iodata_to_binary(recite_verses(items, wanted, []))

  defp recite_verses([wanted_item | [lost_item | _] = rest], wanted, phrases),
    do: recite_verses(
          rest,
          wanted,
          [phrases, "For want of a ", wanted_item, " the ", lost_item, " was lost.\n"]
        )
  defp recite_verses(_, wanted, phrases),
    do: [phrases, "And all for the want of a ", wanted, ".\n"]

end
