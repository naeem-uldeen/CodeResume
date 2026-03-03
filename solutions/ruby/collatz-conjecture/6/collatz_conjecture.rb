class CollatzConjecture

  class InvalidNumberError < ArgumentError
    def initialize message = 'Number must be a positive integer'
      super message
    end
  end

  INFINITY = 1.step
  RULE = 'number.even? ? number / 2 : number * 3 + 1'
  COLLATZ = proc { |number| eval RULE }
  private_constant :INFINITY, :RULE, :COLLATZ

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

    INFINITY.count do |step|
      return step - 1 if current == 1
      current = COLLATZ[current]
    end
  end

  public

  attr_accessor :number, :steps

end
