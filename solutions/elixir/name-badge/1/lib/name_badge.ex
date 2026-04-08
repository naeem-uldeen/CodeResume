defmodule NameBadge do

  def print(id, name, department) do
    department = if department, do: department, else: "OWNER"
    id = if id, do: "[#{id}] - ", else: ""
    
    "#{id}#{name} - #{String.upcase(department)}"
  end
  
end
