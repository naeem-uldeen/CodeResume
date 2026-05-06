defmodule Username do

  @allowed [?_ | Enum.to_list(?a..?z)]

  def sanitize([char | username]) when char in @allowed,
    do: [char | sanitize(username)]

  def sanitize([?ä | username]),
    do: [?a, ?e | sanitize(username)]

  def sanitize([?ö | username]),
    do: [?o, ?e | sanitize(username)]

  def sanitize([?ü | username]),
    do: [?u, ?e | sanitize(username)]

  def sanitize([?ß | username]),
    do: [?s, ?s | sanitize(username)]

  def sanitize([_discard | username]),
    do: sanitize(username)

  def sanitize([]),
    do: []

end
