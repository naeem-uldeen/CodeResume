defmodule AllYourBase do

  @invalid_digits   "all digits must be >= 0 and < input base"
  @invalid_in_base  "input base must be >= 2"
  @invalid_out_base "output base must be >= 2"

  def convert(digits, in_base, out_base) do
    cond do
      in_base < 2  -> {:error, @invalid_in_base}
      out_base < 2 -> {:error, @invalid_out_base}
      Enum.any?(digits, &(&1 < 0 or &1 >= in_base)) ->
        {:error, @invalid_digits}
      true -> {:ok, do_convert(digits, in_base, out_base)}
    end
  end

  defp do_convert(digits, in_base, out_base) do
    digits
    |> Integer.undigits(in_base)
    |> Integer.digits(out_base)
  end

end
