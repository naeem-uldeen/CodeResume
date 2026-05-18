"""
# Elixir DateTime approach — same result
def from(datetime) do
  datetime
  |> NaiveDateTime.from_erl!()
  |> NaiveDateTime.add(@gigasecond, :second)
  |> NaiveDateTime.to_erl()
end
"""
# Erlang :calendar approach
defmodule Gigasecond do
  @gigasecond 1_000_000_000

  def from(datetime) do
    datetime
    |> :calendar.datetime_to_gregorian_seconds()
    |> Kernel.+(@gigasecond)
    |> :calendar.gregorian_seconds_to_datetime()
  end
end
