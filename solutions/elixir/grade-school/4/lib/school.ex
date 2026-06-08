defmodule School do

  @type grade :: integer
  @type student :: {String.t(), grade}
  @type school :: [student]

  def new, do: []

  @spec add(school, String.t(), integer) :: {:ok, school} | {:error, school}
  def add(school, name, grade),
    do: add(school, name, grade, student_exists?(school, name))

  defp add(school, name, grade, false), do: {:ok, [{name, grade} | school]}
  defp add(school, _name, _grade, true), do: {:error, school}

  @spec roster(school) :: [String.t()]
  def roster(school) do
    school
    |> Enum.sort_by(fn {name, grade} -> {grade, name} end)
    |> Enum.map(&elem(&1, 0))
  end

  @spec grade(school, integer) :: [String.t()]
  def grade(school, grade) do
    school
    |> Enum.filter(&match?({_, ^grade}, &1))
    |> Enum.map(&elem(&1, 0))
    |> Enum.sort()
  end

  defp student_exists?(school, name),
    do: Enum.any?(school, &match?({^name, _}, &1))

end
