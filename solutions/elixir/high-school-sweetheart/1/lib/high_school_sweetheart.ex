defmodule HighSchoolSweetheart do

  def first_letter(name) do
    String.trim(name)|> String.first()
  end

  def initial(name) do
    first_letter(name)
    |> String.upcase()
    |> Kernel.<>(".")
  end

  def initials(full_name) do
    Enum.map_join(String.split(full_name), " ", &initial(&1))
  end

  def pair(full_name1, full_name2) do
    i1 = initials(full_name1)
    i2 = initials(full_name2)
    "❤-------------------❤\n|  #{i1}  +  #{i2}  |\n❤-------------------❤\n"
  end

end
