defmodule RobotSimulator do
  @type direction() :: atom()
  @type position() :: {integer(), integer()}
  @type robot() :: {direction(), position()}
  @compass [north: {0, 1}, east: {1, 0}, south: {0, -1}, west: {-1, 0}]
  @directions Keyword.keys(@compass)
  if rem(length(@compass), 4) != 0 do
    raise ArgumentError, "the compass needs a multiple of four directions"
  end
  @right_angle div(length(@compass), 4)

  @spec create(direction(), position()) :: robot() | {:error, String.t()}
  def create(direction \\ :north, position \\ {0, 0}),
    do:
      with(
        true <- direction in @directions || {:error, "invalid direction"},
        true <-
          case position do
            {x, y} when is_integer(x) and is_integer(y) -> true
            _ -> {:error, "invalid position"}
          end,
        do: {direction, position}
      )

  @spec direction(robot()) :: direction()
  def direction({direction, _position}), do: direction

  @spec position(robot()) :: position()
  def position({_direction, position}), do: position

  @spec simulate(robot(), String.t()) :: robot() | {:error, String.t()}
  def simulate(robot, ""), do: robot
  def simulate(robot, "A" <> instructions), do: robot |> advance() |> simulate(instructions)
  def simulate(robot, "L" <> instructions), do: robot |> turn_left() |> simulate(instructions)
  def simulate(robot, "R" <> instructions), do: robot |> turn_right() |> simulate(instructions)
  def simulate(_, _), do: {:error, "invalid instruction"}

  defp advance({direction, {x, y}}) do
    {dx, dy} = Keyword.fetch!(@compass, direction)
    {direction, {x + dx, y + dy}}
  end

  defp turn_left({direction, position}), do: {rotate(direction, -@right_angle), position}
  defp turn_right({direction, position}), do: {rotate(direction, @right_angle), position}

  defp rotate(direction, steps),
    do:
      @directions
      |> Enum.find_index(&(&1 == direction))
      |> Kernel.+(steps)
      |> Integer.mod(length(@directions))
      |> then(&Enum.at(@directions, &1))
end
