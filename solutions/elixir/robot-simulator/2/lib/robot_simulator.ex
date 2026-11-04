defmodule RobotSimulator do
  @directions [:north, :east, :south, :west]

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

  def direction({direction, _position}), do: direction

  def position({_direction, position}), do: position

  def simulate(robot, ""), do: robot
  def simulate(robot, "A" <> instructions), do: robot |> advance() |> simulate(instructions)
  def simulate(robot, "L" <> instructions), do: robot |> turn_left() |> simulate(instructions)
  def simulate(robot, "R" <> instructions), do: robot |> turn_right() |> simulate(instructions)

  def simulate(robot, "T" <> instructions) do
    case Integer.parse(instructions) do
      {degree, instructions} when degree in -359..359 and rem(degree, 90) == 0 ->
        robot |> turn(degree) |> simulate(instructions)
      _ ->
        {:error,
         "T must be followed by an integer degree, a multiple of 90, between -359 and 359"}
    end
  end

  def simulate(_, _), do: {:error, "invalid instruction"}

  defp advance({:north, {x, y}}), do: {:north, {x, y + 1}}
  defp advance({:east, {x, y}}), do: {:east, {x + 1, y}}
  defp advance({:south, {x, y}}), do: {:south, {x, y - 1}}
  defp advance({:west, {x, y}}), do: {:west, {x - 1, y}}

  defp turn_left(robot), do: turn(robot, -90)

  defp turn_right(robot), do: turn(robot, 90)

  defp turn({direction, position}, degree) do
    index = Enum.find_index(@directions, &(&1 == direction))
    quarter_turns = div(degree, 90)

    {Enum.at(@directions, Integer.mod(index + quarter_turns, length(@directions))), position}
  end
end
