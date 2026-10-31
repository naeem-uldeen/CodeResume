defmodule Bowling do
  def start, do: []

  def roll(_game, pins) when pins < 0, do: {:error, "Negative roll is invalid"}
  def roll(_game, pins) when pins > 10, do: {:error, "Pin count exceeds pins on the lane"}
  def roll(game, pins), do: game |> Enum.reverse() |> lane(1) |> place(game, pins)

  def score(game) do
    rolls = Enum.reverse(game)
    settle(lane(rolls, 1), rolls)
  end

  defp place(:over, _game, _pins), do: {:error, "Cannot roll after game is over"}
  defp place({:open, standing}, _game, pins) when pins > standing,
    do: {:error, "Pin count exceeds pins on the lane"}
  defp place({:open, _standing}, game, pins), do: {:ok, [pins | game]}

  defp lane([], _frame), do: {:open, 10}
  defp lane([10 | rest], frame) when frame < 10, do: lane(rest, frame + 1)
  defp lane([first], frame) when frame < 10, do: {:open, 10 - first}
  defp lane([_first, _second | rest], frame) when frame < 10, do: lane(rest, frame + 1)
  defp lane([10], 10), do: {:open, 10}
  defp lane([10, 10], 10), do: {:open, 10}
  defp lane([10, second], 10), do: {:open, 10 - second}
  defp lane([10, _second, _third], 10), do: :over
  defp lane([first], 10), do: {:open, 10 - first}
  defp lane([first, second], 10) when first + second == 10, do: {:open, 10}
  defp lane([_first, _second], 10), do: :over
  defp lane([_first, _second, _third], 10), do: :over

  defp settle(:over, rolls), do: {:ok, frames(rolls, 1, 0)}
  defp settle({:open, _standing}, _rolls),
    do: {:error, "Score cannot be taken until the end of the game"}

  defp frames(_rolls, 11, acc), do: acc
  defp frames([10, first, second | rest], frame, acc),
    do: frames([first, second | rest], frame + 1, acc + 10 + first + second)
  defp frames([first, second, bonus | rest], frame, acc) when first + second == 10,
    do: frames([bonus | rest], frame + 1, acc + 10 + bonus)
  defp frames([first, second | rest], frame, acc),
    do: frames(rest, frame + 1, acc + first + second)
end
