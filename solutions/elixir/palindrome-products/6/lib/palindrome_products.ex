defmodule PalindromeProducts do
  @parallel_tasks System.schedulers_online()

  def generate(max_factor, min_factor \\ 1)
  def generate(max_factor, min_factor) when min_factor > max_factor,
    do: raise(ArgumentError, "min_factor must be less than or equal to max_factor")
  def generate(max_factor, min_factor) do
    with {:ok, results_agent} <- Agent.start_link(fn -> %{} end),
         add_palindrome_pair = fn product, pair ->
           Agent.update(
             results_agent,
             &Map.update(&1, product, [pair], fn pairs -> [pair | pairs] end)
           )
         end,
         tasks =
           Enum.map(0..(@parallel_tasks - 1), fn offset ->
             Task.async(fn ->
               initial_factor = min_factor + offset
               map_generate(
                 add_palindrome_pair,
                 @parallel_tasks,
                 max_factor,
                 initial_factor,
                 initial_factor
               )
             end)
           end),
         _task_results = Task.await_many(tasks, :infinity),
         results = Agent.get(results_agent, & &1),
         :ok = Agent.stop(results_agent) do
      results
    end
  end

  defp map_generate(_add_palindrome_pair, _step, upper_bound, outer_factor, _inner_factor)
       when outer_factor > upper_bound do :ok
  end
  defp map_generate(add_palindrome_pair, step, upper_bound, outer_factor, inner_factor)
       when inner_factor > upper_bound do
    next_outer_factor = outer_factor + step
    map_generate(add_palindrome_pair, step, upper_bound, next_outer_factor, next_outer_factor)
  end
  defp map_generate(add_palindrome_pair, step, upper_bound, outer_factor, inner_factor) do
    product = outer_factor * inner_factor
    maybe_add_palindrome_pair(
      palindrome?(product),
      add_palindrome_pair,
      product,
      outer_factor,
      inner_factor
    )
    map_generate(add_palindrome_pair, step, upper_bound, outer_factor, inner_factor + 1)
  end

  defp maybe_add_palindrome_pair(true, add_palindrome_pair, product, outer_factor, inner_factor),
    do: add_palindrome_pair.(product, [outer_factor, inner_factor])
  defp maybe_add_palindrome_pair(
         false,
         _add_palindrome_pair,
         _product,
         _outer_factor,
         _inner_factor
       ),
       do: :ok

  defp palindrome?(n) when n <= 9, do: true

  for digit_count <- 2..9 do
    max_value = 10 ** digit_count - 1

    comparisons =
      for low <- 0..(digit_count - 1), high = digit_count - 1 - low, low < high do
        low_divisor = 10 ** low
        high_divisor = 10 ** high
        quote do
          rem(div(var!(n), unquote(low_divisor)), 10) ==
            rem(div(var!(n), unquote(high_divisor)), 10)
        end
      end

    [first_comparison | remaining_comparisons] = comparisons

    body =
      Enum.reduce(remaining_comparisons, first_comparison, fn comparison, acc ->
        quote do: unquote(acc) and unquote(comparison)
      end)
    defp palindrome?(n) when n <= unquote(max_value), do: unquote(body)
  end
  
  defp palindrome?(_), do: false
  
end
