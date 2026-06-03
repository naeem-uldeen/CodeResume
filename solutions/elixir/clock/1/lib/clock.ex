defmodule Clock do
  @type t() :: %__MODULE__{hour: integer, minute: integer}
  defstruct hour: 0, minute: 0

  @spec new(integer, integer) :: t()
  def new(hour, minute) do
    total_minutes = Integer.mod(hour * 60 + minute, 1440)
    %Clock{hour: div(total_minutes, 60), minute: rem(total_minutes, 60)}
  end

  @spec add(t(), integer) :: t()
  def add(%Clock{hour: h, minute: m}, add_minute), do: new(h, m + add_minute)
end

defimpl String.Chars, for: Clock do
  def to_string(%Clock{hour: h, minute: m}), do: "#{pad(h)}:#{pad(m)}"
  defp pad(n), do: n |> Integer.to_string() |> String.pad_leading(2, "0")
end
