class SimpleCalculator

  ALLOWED_OPERATIONS = %w[+ - * /]

  def self.calculate a, b, operation
    new(a, b, operation).equation_string
  rescue DivisionByZeroError => error
    error.message
  end

  private

  attr_writer :a, :b, :operation, :answer

  def initialize a, b, operation
    raise InvalidOperandError unless
      a.is_a?(Numeric) && b.is_a?(Numeric)
    raise UnsupportedOperation unless
      ALLOWED_OPERATIONS.include? operation

    self.a = a
    self.b = b
    self.operation = operation
    self.answer = calculate
  end

  def calculate
    raise DivisionByZeroError if
      operation == '/' && b.zero?
    a.public_send(operation, b)
  end

  public

  attr_reader :a, :b, :operation, :answer

  def equation_string
    '%d %s %d = %d' % [a, operation, b, answer]
  end

  class UnsupportedOperation < ArgumentError
    def initialize message = 'Operation must be one of: %s' % [ALLOWED_OPERATIONS.join(', ')]
      super message
    end
  end

  class InvalidOperandError < ArgumentError
    def initialize message = 'Operands must be integers'
      super message
    end
  end

  class DivisionByZeroError < ArgumentError
    def initialize message = 'Division by zero is not allowed.'
      super message
    end
  end

end
