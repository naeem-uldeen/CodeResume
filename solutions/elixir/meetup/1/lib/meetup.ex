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

  @weekdays ~w(monday tuesday wednesday thursday friday saturday sunday)a

  @doc """
  Calculate a meetup date.

  The schedule is in which week (1..4, last or "teenth") the meetup date should
  fall.
  """
  @spec meetup(pos_integer, pos_integer, weekday, schedule) :: Date.t()
  def meetup(year, month, weekday, schedule) do
    last_day = Date.days_in_month(Date.new!(year, month, 1))
    dates = Enum.map(1..last_day, &Date.new!(year, month, &1))
    target = Enum.find_index(@weekdays, &(&1 == weekday))

    matching = Enum.filter(dates, &(Date.day_of_week(&1) == target + 1))

    case schedule do
      :first -> List.first(matching)
      :second -> Enum.at(matching, 1)
      :third -> Enum.at(matching, 2)
      :fourth -> Enum.at(matching, 3)
      :last -> List.last(matching)
      :teenth -> Enum.find(matching, &(&1.day in 13..19))
    end
  end
end
