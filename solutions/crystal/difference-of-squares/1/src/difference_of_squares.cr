module Squares
  extend self

  ONE_TO_NUMBER = -> (number : Int32) { (1..number).to_a }

  def square_of_sum(number : Int32)
    sum = ONE_TO_NUMBER.call(number).sum
    sum * sum
  end

  def sum_of_squares(number : Int32)
    ONE_TO_NUMBER.call(number).sum { |n| n * n }
  end

  def difference_of_squares(number : Int32)
    square_of_sum(number) - sum_of_squares(number)
  end

end

