defmodule School do

  @type grade :: integer
  @type student :: String.t()
  @type school :: %{student => grade}

  def new, do: %{}

  @spec add(school, student, grade) :: {:ok, school} | {:error, school}
  def add(school, name, grade), do: add(school, name, grade, Map.has_key?(school, name))

  defp add(school, _name, _grade, true),  do: {:error, school}
  defp add(school,  name,  grade, false), do: {:ok, Map.put(school, name, grade)}

  @spec roster(school) :: [student]
  def roster(school) do
    school
    |> Enum.sort_by(fn {name, grade} -> {grade, name} end)
    |> Enum.map(&elem(&1, 0))
  end

  @spec grade(school, grade) :: [student]
  def grade(school, grade) do
    school
    |> Enum.filter(fn {_, g} -> g == grade end)
    |> Enum.map(&elem(&1, 0))
    |> Enum.sort()
  end
  
end
