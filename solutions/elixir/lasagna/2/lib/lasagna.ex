defmodule Lasagna do

  def expected_minutes_in_oven, do: 40

  def remaining_minutes_in_oven(actual_minutes),
      do: expected_minutes_in_oven() - actual_minutes

  def preparation_time_in_minutes(layers), do: 2 * layers

  def total_time_in_minutes(layers, actual_minutes),
    do: preparation_time_in_minutes(layers) + actual_minutes

  def alarm, do: "Ding!"

end
