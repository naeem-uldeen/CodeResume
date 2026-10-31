class Squares

  SQUARE_OF_SUM  = ->(n) { (n * (n + 1) / 2)**2 }
  SUM_OF_SQUARES = ->(n) { n * (n + 1) * (2 * n + 1) / 6 }

  private

  attr_writer :number

  def initialize(number)
    self.number = number
  end

  public

  attr_reader :number

  def square_of_sum()= SQUARE_OF_SUM.call(number)

  def sum_of_squares()= SUM_OF_SQUARES.call(number)

  def difference()= square_of_sum - sum_of_squares

end
