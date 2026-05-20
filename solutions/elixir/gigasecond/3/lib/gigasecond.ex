defmodule Gigasecond do

  @giga 1_000_000_000
  
  def from(datetime) do
    datetime
    |> NaiveDateTime.from_erl!()
    |> NaiveDateTime.add(@giga, :second)
    |> NaiveDateTime.to_erl()
  end

end
