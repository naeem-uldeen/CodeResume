defmodule PalindromeProducts do
  @parallel_tasks System.schedulers_online()

  def generate(max_factor, min_factor \\ 1)
  def generate(max_factor, min_factor) when min_factor > max_factor,
    do: raise(ArgumentError, "min_factor must be less than or equal to max_factor")
  def generate(max_factor, min_factor) do
    with {:ok, results_agent} <- Agent.start_link(fn -> %{} end),
         collect_palindrome = fn product, pair ->
           Agent.update(
             results_agent,
             &Map.update(&1, product, [pair], fn pairs -> [pair | pairs] end)
           )
         end,
         tasks =
           Enum.map(0..(@parallel_tasks - 1), fn offset ->
             Task.async(fn ->
               scan_factors(min_factor + offset, max_factor, @parallel_tasks, collect_palindrome)
             end)
           end),
         _task_results = Task.await_many(tasks, :infinity),
         results = Agent.get(results_agent, & &1),
         :ok = Agent.stop(results_agent) do
      results
    end
  end

  defp scan_factors(f1, max_factor, _stride, _collect_palindrome) when f1 > max_factor, do: :ok
  defp scan_factors(f1, max_factor, stride, collect_palindrome) do
    for f2 <- f1..max_factor,
        product = f1 * f2,
        palindrome?(product) do
      collect_palindrome.(product, [f1, f2])
    end
    scan_factors(f1 + stride, max_factor, stride, collect_palindrome)
  end

  defp palindrome?(n), do: digits_match?(n, leading_place_value(n))

  defp leading_place_value(n, place_value \\ 1)
  defp leading_place_value(n, place_value) when n < place_value * 10, do: place_value
  defp leading_place_value(n, place_value), do: leading_place_value(n, place_value * 10)

  defp digits_match?(_remaining_digits, place_value) when place_value <= 1, do: true
  defp digits_match?(remaining_digits, place_value) do
    leading_digit = div(remaining_digits, place_value)
    trailing_digit = rem(remaining_digits, 10)
    leading_digit == trailing_digit and
      digits_match?(remaining_digits |> rem(place_value) |> div(10), div(place_value, 100))
  end
end
