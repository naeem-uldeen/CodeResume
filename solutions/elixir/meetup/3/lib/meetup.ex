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

  @weekday_numbers %{
    monday: 1,
    tuesday: 2,
    wednesday: 3,
    thursday: 4,
    friday: 5,
    saturday: 6,
    sunday: 7
  }

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
  defp schedule_occurrence(first_occurrence, :last), do: last_occurrence(first_occurrence)
  defp schedule_occurrence(first_occurrence, :teenth), do: teenth_occurrence(first_occurrence)

  defp teenth_occurrence(%Date{day: day} = date) when day in 13..19, do: date
  defp teenth_occurrence(date), do: date |> add_weeks(1) |> teenth_occurrence()

  defp last_occurrence(%Date{month: month} = date), do:
    date|> add_weeks(1)|> advance_if_same_month(month, date)

  defp advance_if_same_month(%Date{month: month} = next, month, _current), do: last_occurrence(next)
  defp advance_if_same_month(_next, _month, current), do: current

  defp first_occurrence_of_weekday(date, weekday), do:
    advance_to_weekday(date, Map.fetch!(@weekday_numbers, weekday))

  defp advance_to_weekday(date, target), do:
    select_weekday_match(Date.day_of_week(date) == target, date, target)

  defp select_weekday_match(true, date, _target), do: date
  defp select_weekday_match(false, date, target), do: advance_to_weekday(Date.add(date, 1), target)

  defp add_weeks(date, weeks), do: Date.add(date, weeks * 7)
end
