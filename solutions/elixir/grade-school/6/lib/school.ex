defmodule School do

  @type grade :: integer
  @type student :: String.t()
  @type school :: %{student => grade}

  def new, do: %{}

  @spec add(school, student, grade) :: {:ok | :error, school}
  def add(school, name, grade) do
    case Map.put_new(school, name, grade) do
      ^school  -> {:error, school}
      updated  -> {:ok, updated}
    end
  end

  @spec roster(school) :: [student]
  def roster(school) do
    school
    |> Enum.sort_by(fn {name, grade} -> {grade, name} end)
    |> Enum.map(&elem(&1, 0))
  end

  @spec grade(school, grade) :: [student]
  def grade(school, grade) do
    for({student, ^grade} <- school, do: student) |> Enum.sort()
  end
end
