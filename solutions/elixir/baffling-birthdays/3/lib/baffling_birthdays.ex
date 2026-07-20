defmodule BafflingBirthdays do
  @estimation_sample_size 600

  def shared_birthday?([]), do: false
  def shared_birthday?([%{month: month, day: day} | rest]), do:
    Enum.any?(rest, &match?(%{month: ^month, day: ^day}, &1)) or shared_birthday?(rest)

  def random_birthdates(group_size) do
    start_date = ~D[2023-01-01]
    Enum.map(1..group_size, fn _ ->
      Date.add(start_date, :rand.uniform(365) - 1)
    end)
  end

  def estimated_probability_of_shared_birthday(group_size) do
    shared_count =
      Enum.count(1..@estimation_sample_size, fn _ ->
        group_size
        |> random_birthdates()
        |> shared_birthday?()
      end)
    (shared_count / @estimation_sample_size) * 100
  end
  
end
