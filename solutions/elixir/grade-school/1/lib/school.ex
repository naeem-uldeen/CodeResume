defmodule School do

  @type school :: %{integer => [String.t()]}

  @spec new() :: school
  def new(), do: %{}

  @spec add(school, String.t(), integer) :: {:ok, school} | {:error, school}
  def add(school, name, grade) do
    if student_exists?(school, name) do
      {:error, school}
    else
      students = Map.get(school, grade, [])
      updated = Map.put(school, grade, Enum.sort([name | students]))
      {:ok, updated}
    end
  end

  @spec roster(school) :: [String.t()]
  def roster(school) do
    school
    |> Enum.sort_by(fn {grade, _} -> grade end)
    |> Enum.flat_map(fn {_, students} -> students end)
  end

  @spec grade(school, integer) :: [String.t()]
  def grade(school, grade), do: Map.get(school, grade, [])

  defp student_exists?(school, name), do:
    Enum.any?(school, fn {_grade, students} -> name in students end)

end
