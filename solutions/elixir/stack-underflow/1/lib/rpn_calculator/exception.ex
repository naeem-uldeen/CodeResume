defmodule RPNCalculator.Exception do

  @div "when dividing"

  defmodule DivisionByZeroError, do: defexception message: "division by zero occurred"

  defmodule StackUnderflowError do
    @su "stack underflow occurred"
    defexception message: @su

    @impl true
    def exception([]),  do: %StackUnderflowError{}
    def exception(nil), do: %StackUnderflowError{}
    def exception(ctx), do: %StackUnderflowError{message: @su <> ", context: #{ctx}"}
  end

  def divide([]),     do: raise(StackUnderflowError, @div)
  def divide([_]),    do: raise(StackUnderflowError, @div)
  def divide([0, _]), do: raise(DivisionByZeroError)
  def divide([divisor, dividend]), do: dividend / divisor

end
