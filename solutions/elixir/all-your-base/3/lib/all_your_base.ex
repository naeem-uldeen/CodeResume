defmodule AllYourBase do

  @invalid_digits   "all digits must be >= 0 and < input base"
  @invalid_in_base  "input base must be >= 2"
  @invalid_out_base "output base must be >= 2"

  def convert(digits, in_base, out_base) do
    with true <- in_base  >= 2 || {:error, @invalid_in_base},
         true <- out_base >= 2 || {:error, @invalid_out_base},
         # collapse input digits to an integer,
         # then expand into output base
         {:ok, value} <- to_integer(digits, in_base) do
      {:ok, to_digits(value, out_base)}
    end
  end

  # ── digits → integer ──────────────────────────────────────────

  # seed the accumulator
  defp to_integer(digits, base), do: to_integer(digits, base, 0)

  # base clause: list exhausted, accumulator is the final integer
  defp to_integer([], _base, acc), do: {:ok, acc}

  # guard: reject any digit outside 0..base-1
  defp to_integer([digit | _], base, _acc) when digit < 0 or digit >= base,
    do: {:error, @invalid_digits}

  # shift accumulator up one place, add next digit
  defp to_integer([digit | rest], base, acc),
    do: to_integer(rest, base, acc * base + digit)

  # ── integer → digits ──────────────────────────────────────────

  # special case: zero produces [0], not []
  defp to_digits(0, _base), do: [0]

  # seed the accumulator
  defp to_digits(value, base), do: to_digits(value, base, [])

  # base clause: nothing left to peel, return collected digits
  defp to_digits(0, _base, acc), do: acc

  # peel least-significant digit, prepend to keep order correct
  defp to_digits(value, base, acc),
    do: to_digits(div(value, base), base, [rem(value, base) | acc])

end
