defmodule School do

  @type school :: %{integer => [String.t()]}

  def new, do: %{}

  @spec add(school, String.t(), integer) :: {:ok, school} | {:error, school}
  def add(school, name, grade) do
    if student_exists?(school, name) do {:error, school}
    else
      updated = Map.update(school, grade, [name], &Enum.sort([name | &1]))
      {:ok, updated}
    end
  end

  @spec roster(school) :: [String.t()]
  def roster(school) do
    school
    |> Enum.sort_by(&elem(&1, 0))
    |> Enum.flat_map(&elem(&1, 1))
  end

  @spec grade(school, integer) :: [String.t()]
  def grade(school, grade) when is_map_key(school, grade), do: Map.fetch!(school, grade)
  def grade(_, _), do: []

  defp student_exists?(school, name) do
    Enum.any?(school, &(name in elem(&1, 1)))
  end
  
end
