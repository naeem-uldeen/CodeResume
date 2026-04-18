defmodule Garden do

  @students [
    :alice, :bob,   :charlie, :david,
    :eve,   :fred,  :ginny,   :harriet,
    :ileana, :joseph, :kincaid, :larry
  ]

  defstruct @students |> Enum.map(&{&1, {}})

  defp plant(?C), do: :clover
  defp plant(?G), do: :grass
  defp plant(?R), do: :radishes
  defp plant(?V), do: :violets
  defp plant(_),  do: nil

  defp build_garden([], _plants1, _plants2, _i, garden), do: garden

  defp build_garden([student | rest], plants1, plants2, i, garden) do
    plants = plants_at(plants1, plants2, i)
    new_garden = Map.put(garden, student, plants)
    build_garden(rest, plants1, plants2, i + 1, new_garden)
  end

  defp plants_at(_plants1, _plants2, i) when i < 0, do: {}

  defp plants_at(plants1, plants2, i) do
    i = i * 2
    [
      Enum.at(plants1, i),
      Enum.at(plants1, i + 1),
      Enum.at(plants2, i),
      Enum.at(plants2, i + 1)
    ]
    |> Enum.map(&plant/1)
    |> Enum.reject(&is_nil/1)
    |> List.to_tuple()
  end

  def info(garden), do: info(garden, @students)

  def info(garden, students) do
    [row1, row2] = String.split(garden, "\n")
    plants1 = String.to_charlist(row1)
    plants2 = String.to_charlist(row2)
    sorted_students = Enum.sort(students)
    build_garden(sorted_students, plants1, plants2, 0, %{})
  end
  
end
