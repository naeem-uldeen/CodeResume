defmodule Garden do

  @students [
    :alice, :bob,     :charlie, :david,
    :eve,   :fred,    :ginny,   :harriet,
    :ileana, :joseph, :kincaid, :larry
  ]

  defp plant(?C), do: :clover
  defp plant(?G), do: :grass
  defp plant(?R), do: :radishes
  defp plant(?V), do: :violets

  defp plants_for(row, index) do
    row
    |> String.to_charlist()
    |> Enum.slice(index * 2, 2)
    |> Enum.map(&plant/1)
  end

  defp build_garden([], _row1, _row2, _index), do: %{}

  defp build_garden([student | rest], row1, row2, index) do
    plants =
      (plants_for(row1, index) ++ plants_for(row2, index))
      |> List.to_tuple()
    Map.put(build_garden(rest, row1, row2, index + 1), student, plants)
  end

  def info(garden), do: info(garden, @students)

  def info(garden, students) do
    [row1, row2]     = String.split(garden, "\n")
    sorted_students  = Enum.sort(students)
    build_garden(sorted_students, row1, row2, 0)
  end

end
