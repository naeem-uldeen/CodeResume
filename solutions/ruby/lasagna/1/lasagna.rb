class Lasagna

  EXPECTED_MINUTES_IN_OVEN = 40
  MINUTES_FOR_PREPARATION = 2

  def remaining_minutes_in_oven(actual_minutes)
    EXPECTED_MINUTES_IN_OVEN - actual_minutes
  end

  def preparation_time_in_minutes(layers)
    MINUTES_FOR_PREPARATION * layers
  end

  def total_time_in_minutes(number_of_layers:, actual_minutes_in_oven:)
    preparation_time_in_minutes(number_of_layers) + actual_minutes_in_oven
  end

end

