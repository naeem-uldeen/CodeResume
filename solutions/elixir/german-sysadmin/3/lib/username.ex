defmodule Username do

 def sanitize([character | username]) when
   character in ?a..?z or character == ?_,
     do: [character | sanitize(username)]
 def sanitize([?ä | username]), do: [?a, ?e | sanitize(username)]
 def sanitize([?ö | username]), do: [?o, ?e | sanitize(username)]
 def sanitize([?ü | username]), do: [?u, ?e | sanitize(username)]
 def sanitize([?ß | username]), do: [?s, ?s | sanitize(username)]
 def sanitize([_discard | username]), do: sanitize(username)
 def sanitize([]), do: []

end
