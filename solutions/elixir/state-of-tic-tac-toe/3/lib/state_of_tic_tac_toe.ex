defmodule StateOfTicTacToe do
  @moduledoc """
  Determines the state of a tic-tac-toe game from its board representation.
  """

  @doc """
  Returns `{:ok, state}` for a valid board, or `{:error, reason}` if the
  board could not have resulted from a legal game.
  """
  @spec game_state(String.t()) :: {:ok, :win | :draw | :ongoing} | {:error, String.t()}
  def game_state(
        <<_::binary-size(3), "\n", _::binary-size(3), "\n", _::binary-size(3), "\n">> = board
      ) do
    {x_count, o_count, blank?} = scan_cells(board)
    x_wins = win?(board, ?X)
    o_wins = win?(board, ?O)

    impossible? =
      (x_wins and o_wins) or
        (x_wins and x_count != o_count + 1) or
        (o_wins and x_count != o_count)

    cond do
      o_count > x_count -> {:error, "Wrong turn order: O started"}
      x_count > o_count + 1 -> {:error, "Wrong turn order: X went twice"}
      impossible? -> {:error, "Impossible board: game should have ended after the game was won"}
      x_wins or o_wins -> {:ok, :win}
      blank? -> {:ok, :ongoing}
      true -> {:ok, :draw}
    end
  end

  defp scan_cells(board) do
    freqs = board |> String.graphemes() |> Enum.frequencies()
    {Map.get(freqs, "X", 0), Map.get(freqs, "O", 0), Map.has_key?(freqs, ".")}
  end

  # Rows
  defp win?(<<mark, mark, mark, "\n", _, _, _, "\n", _, _, _, "\n">>, mark), do: true
  defp win?(<<_, _, _, "\n", mark, mark, mark, "\n", _, _, _, "\n">>, mark), do: true
  defp win?(<<_, _, _, "\n", _, _, _, "\n", mark, mark, mark, "\n">>, mark), do: true
  # Columns
  defp win?(<<mark, _, _, "\n", mark, _, _, "\n", mark, _, _, "\n">>, mark), do: true
  defp win?(<<_, mark, _, "\n", _, mark, _, "\n", _, mark, _, "\n">>, mark), do: true
  defp win?(<<_, _, mark, "\n", _, _, mark, "\n", _, _, mark, "\n">>, mark), do: true
  # Diagonals
  defp win?(<<mark, _, _, "\n", _, mark, _, "\n", _, _, mark, "\n">>, mark), do: true
  defp win?(<<_, _, mark, "\n", _, mark, _, "\n", mark, _, _, "\n">>, mark), do: true
  defp win?(_, _), do: false
  
end
