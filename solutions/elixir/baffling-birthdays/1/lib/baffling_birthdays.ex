defmodule BafflingBirthdays do

  def shared_birthday?(birthdates) do
    Enum.reduce_while(birthdates, MapSet.new(), fn b_day, seen ->
      month_day = {b_day.month, b_day.day}
      if MapSet.member?(seen, month_day) do
        {:halt, true}
      else
        {:cont, MapSet.put(seen, month_day)}
      end
    end)
    |> case do
      true -> true
      _set -> false
    end
  end

  def random_birthdates(group_size) do
    start_date = ~D[2023-01-01]
    Enum.map(1..group_size, fn _ ->
      Date.add(start_date, :rand.uniform(365) - 1)
    end)
  end

  def estimated_probability_of_shared_birthday(group_size) do
    total_simulations = 10_000
    shared_count =
      Enum.count(1..total_simulations, fn _ ->
        group_size
        |> random_birthdates()
        |> shared_birthday?()
      end)
    (shared_count / total_simulations) * 100
  end
end
