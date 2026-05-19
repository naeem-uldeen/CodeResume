defmodule Gigasecond do

  @gigasecond 1_000_000_000
  
  def from(datetime) do
    datetime
    |> :calendar.datetime_to_gregorian_seconds()
    |> Kernel.+(@gigasecond)
    |> :calendar.gregorian_seconds_to_datetime()
  end

end
