defmodule RPNCalculator.Exception do

  defmodule DivisionByZeroError, do: defexception(message: "division by zero occurred")

  defmodule StackUnderflowError do
    defexception message: "stack underflow occurred"
    @impl true

    def exception([]),  do: %StackUnderflowError{}
    def exception(context),
      do: %StackUnderflowError {message: "stack underflow occurred, context: #{context}"}
  end

  def divide([0, _dividend | _]), do: raise(DivisionByZeroError)
  def divide([divisor, dividend | _]), do: dividend / divisor
  def divide(_), do: raise(StackUnderflowError, "when dividing")

end
