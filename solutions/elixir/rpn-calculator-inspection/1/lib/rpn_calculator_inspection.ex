defmodule RPNCalculatorInspection do

  def start_reliability_check(calculator, input) do
    pid = spawn_link(fn -> calculator.(input) end)
    %{input: input, pid: pid}
  end

  def await_reliability_check_result(%{input: input, pid: pid}, acc) do
    receive do
      {:EXIT, ^pid, :normal} -> Map.put(acc, input, :ok)
      {:EXIT, ^pid, _reason} -> Map.put(acc, input, :error)
    after
      100 -> Map.put(acc, input, :timeout)
    end
  end

  def reliability_check(calculator, inputs) do
    old_trap_exit = Process.flag(:trap_exit, true)

    results =
      inputs
      |> Enum.map(&start_reliability_check(calculator, &1))
      |> Enum.reduce(%{}, &await_reliability_check_result/2)

    Process.flag(:trap_exit, old_trap_exit)

    results
  end

  def correctness_check(calculator, inputs) do
    inputs
    |> Enum.map(&Task.async(fn -> calculator.(&1) end))
    |> Task.await_many(100)
  end

end
