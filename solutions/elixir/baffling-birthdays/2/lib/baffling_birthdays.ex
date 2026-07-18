defmodule BafflingBirthdays do
  @estimation_sample_size 600

  def shared_birthday?(birthdates), do: do_shared_birthday?(birthdates, MapSet.new())

  defp do_shared_birthday?([], _seen), do: false
  defp do_shared_birthday?([%{month: m, day: d} | rest], seen) do
    month_day = {m, d}
    if MapSet.member?(seen, month_day) do
      true
    else
      do_shared_birthday?(rest, MapSet.put(seen, month_day))
    end
  end

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
