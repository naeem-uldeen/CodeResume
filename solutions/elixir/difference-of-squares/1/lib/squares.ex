defmodule Squares do

  def sum_of_squares(upper_limit), do:
    div(upper_limit * (upper_limit + 1) * (2 * upper_limit + 1), 6)

  def square_of_sum(upper_limit) do
    triangular_number = div(upper_limit * (upper_limit + 1), 2)
    triangular_number * triangular_number
  end

  def difference(upper_limit), do:
    square_of_sum(upper_limit) - sum_of_squares(upper_limit)

end
