defmodule RobotSimulator do
  @directions [:north, :east, :south, :west]

  def create(direction \\ :north, position \\ {0, 0})
  def create(direction, _position) when direction not in @directions,
    do: {:error, "invalid direction"}
  def create(direction, {x, y}) when is_integer(x) and is_integer(y),
    do: {direction, {x, y}}
  def create(_direction, _position), do: {:error, "invalid position"}

  def simulate(robot, instructions) when is_binary(instructions),
    do: execute(instructions, robot)

  def direction({direction, _position}), do: direction

  def position({_direction, position}), do: position

  defp execute(_instructions, {:error, _reason} = error), do: error
  defp execute("", robot), do: robot
  defp execute(<<instruction::binary-size(1), rest::binary>>, robot),
    do: execute(rest, step(instruction, robot))

  defp step("R", {direction, position}), do: {turn_right(direction), position}
  defp step("L", {direction, position}), do: {turn_left(direction), position}
  defp step("A", {direction, position}), do: {direction, advance(direction, position)}
  defp step(_invalid, _robot), do: {:error, "invalid instruction"}

  defp turn_right(:north), do: :east
  defp turn_right(:east), do: :south
  defp turn_right(:south), do: :west
  defp turn_right(:west), do: :north

  defp turn_left(:north), do: :west
  defp turn_left(:west), do: :south
  defp turn_left(:south), do: :east
  defp turn_left(:east), do: :north

  defp advance(:north, {x, y}), do: {x, y + 1}
  defp advance(:east, {x, y}), do: {x + 1, y}
  defp advance(:south, {x, y}), do: {x, y - 1}
  defp advance(:west, {x, y}), do: {x - 1, y}
end
