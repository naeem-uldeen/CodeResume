defmodule School do

  @type school :: %{integer => [String.t()]}

  @spec new() :: school
  def new, do: %{}

  @spec add(school, String.t(), integer) :: {:ok, school} | {:error, school}
  def add(school, name, grade) when is_binary(name) and is_integer(grade) do
    if student_exists?(school, name) do
      {:error, school}
    else
      updated = Map.update(school, grade, [name], &Enum.sort([name | &1]))
      {:ok, updated}
    end
  end
  def add(_, _, _), do: {:error, %{}}

  @spec roster(school) :: [String.t()]
  def roster(school), do: school |> Enum.sort_by(&elem(&1, 0)) |> Enum.flat_map(&elem(&1, 1))

  @spec grade(school, integer) :: [String.t()]
  def grade(school, grade), do: Map.get(school, grade, [])

  defp student_exists?(school, name), do: Enum.any?(school, &(elem(&1, 1) |> Enum.member?(name)))
  
end
