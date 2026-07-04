defmodule StateOfTicTacToe do

  @row_stride 4
  @lines for(row <- 0..2, do: [{row, 0}, {row, 1}, {row, 2}]) ++
           for(col <- 0..2, do: [{0, col}, {1, col}, {2, col}]) ++
           [[{0, 0}, {1, 1}, {2, 2}], [{0, 2}, {1, 1}, {2, 0}]]
  @wrong_turn_o_started {:error, "Wrong turn order: O started"}
  @wrong_turn_x_twice {:error, "Wrong turn order: X went twice"}
  @impossible_board {:error, "Impossible board: game should have ended after the game was won"}
  @win {:ok, :win}
  @draw {:ok, :draw}
  @ongoing {:ok, :ongoing}

  def game_state(<<_, _, _, ?\n, _, _, _, ?\n, _, _, _, ?\n>> = board) do
    {x_count, o_count} = count_marks(board, 0, 0)
    x_wins = win?(board, ?X)
    o_wins = win?(board, ?O)

    with true <- x_count <= o_count + 1 || @wrong_turn_x_twice,
         true <- o_count <= x_count || @wrong_turn_o_started,
         true <- not (x_wins and o_wins) || @impossible_board,
         true <- not (x_wins and x_count != o_count + 1) || @impossible_board,
         true <- not (o_wins and x_count != o_count) || @impossible_board do
      cond do
        x_wins or o_wins -> @win
        x_count + o_count == 9 -> @draw
        true -> @ongoing
      end
    end
  end

  defp count_marks(<<>>, x_count, o_count), do: {x_count, o_count}
  defp count_marks(<<?X, rest::binary>>, x_count, o_count),
    do: count_marks(rest, x_count + 1, o_count)
  defp count_marks(<<?O, rest::binary>>, x_count, o_count),
    do: count_marks(rest, x_count, o_count + 1)
  defp count_marks(<<?., rest::binary>>, x_count, o_count),
    do: count_marks(rest, x_count, o_count)
  defp count_marks(<<?\n, rest::binary>>, x_count, o_count),
    do: count_marks(rest, x_count, o_count)

  defp win?(board, mark), do:
    Enum.any?(@lines, fn line -> Enum.all?(line, &(mark_at(board, &1) == mark)) end)
  
  defp mark_at(board, {row, col}), do: :binary.at(board, @row_stride * row + col)
  
end
