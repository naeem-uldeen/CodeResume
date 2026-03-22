class SimpleCalculator

  ALLOWED_OPERATIONS = %w[+ - * /]

  def self.calculate(first_operand, second_operand, operation)
    new(first_operand, second_operand, operation).equation_string
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
    raise DivisionByZeroError if
      operation == '/' && second_operand.zero?
    first_operand.public_send(operation, second_operand)
  end

  public

  attr_reader :first_operand, :second_operand, :operation, :answer

  def equation_string
    '%d %s %d = %d' % [first_operand, operation, second_operand, answer]
  end

  class UnsupportedOperation < ArgumentError
    def initialize(message = nil)
      super message || 'Operation must be one of: %s' % [ALLOWED_OPERATIONS.join(', ')]
    end
  end

  class InvalidOperandError < ArgumentError
    def initialize(message = nil)
      super message || 'Operands must be integers'
    end
  end

  class DivisionByZeroError < ArgumentError
    def initialize(message = nil)
      super message || 'Division by zero is not allowed.'
    end
  end

end
