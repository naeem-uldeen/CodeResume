class CollatzConjecture

  class InvalidNumberError < ArgumentError
    def initialize message = 'Number must be a positive integer'
      super
    end
  end

  STEP_COUNTER = 0.step
  COLLATZ = ->(number) { number.even? ? number / 2 : number * 3 + 1 }
  private_constant :STEP_COUNTER, :COLLATZ

  def self.steps number
    new(number).steps
  end

  private

  attr_writer :number, :steps

  def initialize number
    number.positive? or raise InvalidNumberError
    self.number = number
    self.steps = calculate_steps
  end

  def calculate_steps
    current = number

    STEP_COUNTER.count do |step|
      return step if current == 1
      current = COLLATZ[current]
    end
  end

  public

  attr_reader :number, :steps

end
