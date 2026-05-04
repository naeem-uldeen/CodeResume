defmodule Username do

  def sanitize([?ä | rest]), do: [?a, ?e | sanitize(rest)]
  def sanitize([?ö | rest]), do: [?o, ?e | sanitize(rest)]
  def sanitize([?ü | rest]), do: [?u, ?e | sanitize(rest)]
  def sanitize([?ß | rest]), do: [?s, ?s | sanitize(rest)]
  def sanitize([character | rest]) when
    character in ?a..?z or character == ?_,
      do: [character | sanitize(rest)]
  def sanitize([ _ | rest]), do: sanitize(rest)
  def sanitize([]),          do: []

end
