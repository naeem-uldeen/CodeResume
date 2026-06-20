defmodule LibraryFees do

  def datetime_from_string(string), do: NaiveDateTime.from_iso8601!(string)

  def before_noon?(datetime), do: datetime.hour < 12

  def return_date(%{hour: hour} = checkout_datetime) when hour < 12,
    do: checkout_datetime |> NaiveDateTime.to_date() |> Date.add(28)

  def return_date(checkout_datetime),
    do: checkout_datetime |> NaiveDateTime.to_date() |> Date.add(29)

  def days_late(planned_return_date, actual_return_datetime),
    do: max(Date.diff(NaiveDateTime.to_date(actual_return_datetime), planned_return_date), 0)

  def monday?(datetime), do: datetime |> NaiveDateTime.to_date() |> Date.day_of_week() == 1

  def calculate_late_fee(checkout, return, rate) do
    return_datetime = datetime_from_string(return)
    late_days = checkout |> datetime_from_string() |> return_date() |> days_late(return_datetime)
    trunc(late_days * rate * discount_multiplier(monday?(return_datetime)))
  end

  defp discount_multiplier(true), do: 0.5
  defp discount_multiplier(false), do: 1
  
end
