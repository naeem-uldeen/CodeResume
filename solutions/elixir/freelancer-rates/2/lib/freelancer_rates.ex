defmodule FreelancerRates do

  @working_hours_per_day 8.0
  @billable_days_per_month 22.0

  def daily_rate(hourly_rate),
    do: @working_hours_per_day * hourly_rate

  def apply_discount(base_rate, discount),
    do: base_rate - (base_rate * discount/100)

  def monthly_rate(hourly_rate, discount),
    do:
      hourly_rate
      |> daily_rate()
      |> Kernel.*(@billable_days_per_month)
      |> apply_discount(discount)
      |> ceil()

  def days_in_budget(budget, hourly_rate, discount),
    do:
      budget
      |> Kernel./(hourly_rate |> daily_rate() |> apply_discount(discount))
      |> Float.floor(1)
end
