defmodule NameBadge do

  def print(id, name, department) do
    "#{if(id, do: "[#{id}] - ")}" <>
    "#{name} - #{String.upcase(department || "OWNER")}"
  end
  
end
