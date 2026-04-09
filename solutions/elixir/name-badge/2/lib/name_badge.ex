defmodule NameBadge do

  def print(id, name, department) do
    id_prefix = if id, do: "[#{id}] - ", else: ""
    "#{id_prefix}#{name} - #{String.upcase(department || "OWNER")}"
  end
  
end
