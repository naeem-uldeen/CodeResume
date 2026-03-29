class CollatzConjecture

  def self.steps(number : Int32) : Int32
    new(number).steps
  end

  private property number : Int32

  private def initialize(number : Int32)
    raise ArgumentError.new unless number >= 1
    @number = number
  end

  private def collatz_count(number : Int32, steps : Int32) : Int32
    return steps if number == 1
    collatz_count(
      number.even? ?
      number // 2 :
      3 * number + 1,

      steps + 1)
  end

  def steps : Int32
    collatz_count(number, 0)
  end

end
