defmodule LibraryFees do

  def datetime_from_string(string), do: NaiveDateTime.from_iso8601!(string)

  def before_noon?(datetime), do: datetime.hour < 12

  def return_date(checkout_datetime) do
    checkout_datetime
    |> NaiveDateTime.to_date()
    |> Date.add(checkout_period(before_noon?(checkout_datetime)))
  end

  def days_late(planned_return_date, actual_return_datetime),
    do: max(Date.diff(NaiveDateTime.to_date(actual_return_datetime), planned_return_date), 0)

  def monday?(datetime), do: datetime |> NaiveDateTime.to_date() |> Date.day_of_week() == 1

  def calculate_late_fee(checkout, return, rate) do
    with checkout_datetime = datetime_from_string(checkout),
         return_datetime = datetime_from_string(return),
         late_days = days_late(return_date(checkout_datetime), return_datetime),
         discount = if(monday?(return_datetime), do: 0.5, else: 1.0) do
      trunc(late_days * rate * discount)
    end
  end

  defp checkout_period(true), do: 28
  defp checkout_period(false), do: 29
  
end
