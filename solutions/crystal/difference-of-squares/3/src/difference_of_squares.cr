module Squares
  extend self

  private def range_to(number : Int32)
    1..number
  end

  def square_of_sum(number : Int32)
    sum = range_to(number).sum
    sum * sum
  end

  def sum_of_squares(number : Int32)
    range_to(number).sum(&.**(2))
  end

  def difference_of_squares(number : Int32)
    square_of_sum(number) - sum_of_squares(number)
  end

end
