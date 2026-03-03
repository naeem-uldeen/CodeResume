class SimpleCalculator

  ALLOWED_OPERATIONS = %w[+ - * /]

  def self.calculate(first_operand, second_operand, operation)
    new(first_operand, second_operand, operation).to_s

  rescue DivisionByZeroError => e
    e.message
  end

  private

  attr_writer :first_operand, :second_operand, :operation, :answer

  def initialize first_operand, second_operand, operation
    raise InvalidOperandError unless
      first_operand.is_a?(Numeric) && second_operand.is_a?(Numeric)
    raise UnsupportedOperation unless
      ALLOWED_OPERATIONS.include?(operation)

    self.first_operand = first_operand
    self.second_operand = second_operand
    self.operation = operation
    self.answer = calculate
  end

  def calculate
    raise DivisionByZeroError if operation == '/' && second_operand.zero?
    eval "#{first_operand} #{operation} #{second_operand}"
  end

  public

  attr_reader :first_operand, :second_operand, :operation, :answer

  def to_s
    '%d %s %d = %d' % [first_operand, operation, second_operand, answer]
  end

  class UnsupportedOperation < ArgumentError
    def initialize message = 'Operation must be one of: %s' % [ALLOWED_OPERATIONS.join(', ')]
      super
    end
  end

  class InvalidOperandError < ArgumentError
    def initialize message = 'Operands must be integers'
      super
    end
  end

  class DivisionByZeroError < ArgumentError
    def initialize message = 'Division by zero is not allowed.'
      super
    end
  end

end
