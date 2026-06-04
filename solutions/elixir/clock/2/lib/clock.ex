defmodule Clock do

  @minutes_per_day 24 * 60
  @type hour() :: 0..23
  @type minute() :: 0..59
  @type t() :: %__MODULE__{hour: hour(), minute: minute()}

  defstruct hour: 0, minute: 0

  @spec new(integer, integer) :: t()
  def new(hour, minute) do
    minute_of_day = Integer.mod(hour * 60 + minute, @minutes_per_day)
    %Clock{hour: div(minute_of_day, 60), minute: rem(minute_of_day, 60)}
  end

  @spec add(t(), minutes :: integer) :: t()
  def add(%Clock{hour: h, minute: m}, minutes), do: new(h, m + minutes)
  
end

defimpl String.Chars, for: Clock do
  @fmt ~c"~2..0B:~2..0B"
  def to_string(%Clock{hour: h, minute: m}), do: IO.iodata_to_binary(:io_lib.format(@fmt, [h, m]))
end
