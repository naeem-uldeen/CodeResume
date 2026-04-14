defmodule FreelancerRates do

  @working_hours 8.0
  @billable_days 22.0

  def daily_rate(hourly_rate), do: @working_hours * hourly_rate

  def apply_discount(base_rate, discount),
    do: base_rate - (base_rate * discount/100)

  def monthly_rate(hourly_rate, discount) do
    base_monthly_rate = @billable_days * daily_rate(hourly_rate)
    discounted = apply_discount(base_monthly_rate, discount)

    ceil(discounted)
  end

  def days_in_budget(budget, hourly_rate, discount) do
    discounted_daily_rate = apply_discount(daily_rate(hourly_rate), discount)
    days = budget / discounted_daily_rate

    Float.floor(days, 1)
  end

end
