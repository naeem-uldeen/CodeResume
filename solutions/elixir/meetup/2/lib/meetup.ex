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
    first = Date.new!(year, month, 1)
    days_in_month = Date.days_in_month(first)
    target = Map.fetch!(@weekday_numbers, weekday)

    first_match_day = 1 + rem(target - Date.day_of_week(first) + 7, 7)

    matching =
      first_match_day
      |> Stream.iterate(&(&1 + 7))
      |> Enum.take_while(&(&1 <= days_in_month))
      |> Enum.map(&Date.new!(year, month, &1))

    pick(matching, schedule)
  end

  defp pick([date | _], :first), do: date
  defp pick(dates, :second), do: Enum.at(dates, 1)
  defp pick(dates, :third), do: Enum.at(dates, 2)
  defp pick(dates, :fourth), do: Enum.at(dates, 3)
  defp pick(dates, :last), do: List.last(dates)
  defp pick(dates, :teenth), do: Enum.find(dates, &(&1.day in 13..19))
end
