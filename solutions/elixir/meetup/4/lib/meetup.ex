defmodule Meetup do
  @moduledoc """
  Calculate meetup dates.
  """

  @type weekday ::
          :monday
          | :tuesday
          | :wednesday
          | :thursday
          | :friday
          | :saturday
          | :sunday

  @type schedule :: :first | :second | :third | :fourth | :last | :teenth

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: Date.t()
  def meetup(year, month, weekday, schedule) do
    first_of_month = Date.new!(year, month, 1)
    first_occurrence = first_occurrence_of_weekday(first_of_month, weekday)

    schedule_occurrence(first_occurrence, schedule)
  end

  defp schedule_occurrence(first_occurrence, :first), do: first_occurrence
  defp schedule_occurrence(first_occurrence, :second), do: add_weeks(first_occurrence, 1)
  defp schedule_occurrence(first_occurrence, :third), do: add_weeks(first_occurrence, 2)
  defp schedule_occurrence(first_occurrence, :fourth), do: add_weeks(first_occurrence, 3)

  defp schedule_occurrence(first_occurrence, :last) do
    %{day: last_day} = Date.end_of_month(first_occurrence)
    find_occurrence(first_occurrence, &(&1.day in (last_day - 6)..last_day))
  end

  defp schedule_occurrence(first_occurrence, :teenth),
    do: find_occurrence(first_occurrence, &(&1.day in 13..19))

  defp find_occurrence(date, predicate) do
    if predicate.(date) do
      date
    else
      date |> add_weeks(1) |> find_occurrence(predicate)
    end
  end

  defp first_occurrence_of_weekday(date, weekday) do
    offset = rem(7 + day_of_week(weekday) - Date.day_of_week(date), 7)
    Date.add(date, offset)
  end

  defp day_of_week(:monday), do: 1
  defp day_of_week(:tuesday), do: 2
  defp day_of_week(:wednesday), do: 3
  defp day_of_week(:thursday), do: 4
  defp day_of_week(:friday), do: 5
  defp day_of_week(:saturday), do: 6
  defp day_of_week(:sunday), do: 7

  defp add_weeks(date, weeks), do: Date.add(date, weeks * 7)
end
