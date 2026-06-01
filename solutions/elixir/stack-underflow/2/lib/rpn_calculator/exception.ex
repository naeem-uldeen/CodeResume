defmodule RPNCalculator.Exception do

  defmodule DivisionByZeroError, do: defexception(message: "division by zero occurred")

  defmodule StackUnderflowError do
    defexception message: "stack underflow occurred"

    @impl true
    def exception([]),  do: %StackUnderflowError{}
    def exception(ctx), do: %StackUnderflowError{message: "stack underflow occurred" <> ", context: #{ctx}"}
  end

  def divide([]),     do: raise(StackUnderflowError, "when dividing")
  def divide([_]),    do: raise(StackUnderflowError, "when dividing")
  def divide([0, _]), do: raise(DivisionByZeroError)
  def divide([divisor, dividend | _]), do: dividend / divisor

end
