defmodule StateOfTicTacToe do

  @wrong_turn_o_started {:error, "Wrong turn order: O started"}
  @wrong_turn_x_twice {:error, "Wrong turn order: X went twice"}
  @impossible_board {:error, "Impossible board: game should have ended after the game was won"}
  @win {:ok, :win}
  @draw {:ok, :draw}
  @ongoing {:ok, :ongoing}

  def game_state(<<row1::binary-size(3), "\n", row2::binary-size(3), "\n", row3::binary-size(3), "\n">>) do
    {x_count, o_count, blank?} = scan_cells(<<row1::binary, row2::binary, row3::binary>>)
    x_wins = win?(row1, row2, row3, ?X)
    o_wins = win?(row1, row2, row3, ?O)
    state(x_count, o_count, x_wins, o_wins, blank?)
  end

  defp scan_cells(cells), do: scan_cells(cells, 0, 0, false)
  defp scan_cells(<<>>, x_count, o_count, blank?), do: {x_count, o_count, blank?}

  defp scan_cells(<<?X, rest::binary>>, x_count, o_count, blank?),
    do: scan_cells(rest, x_count + 1, o_count, blank?)

  defp scan_cells(<<?O, rest::binary>>, x_count, o_count, blank?),
    do: scan_cells(rest, x_count, o_count + 1, blank?)

  defp scan_cells(<<?., rest::binary>>, x_count, o_count, _blank?),
    do: scan_cells(rest, x_count, o_count, true)

  defp state(x_count, o_count, _, _, _) when o_count > x_count, do: @wrong_turn_o_started
  defp state(x_count, o_count, _, _, _) when x_count > o_count + 1, do: @wrong_turn_x_twice
  defp state(_, _, true, true, _), do: @impossible_board
  defp state(x_count, o_count, true, false, _) when x_count != o_count + 1, do: @impossible_board
  defp state(x_count, o_count, false, true, _) when x_count != o_count, do: @impossible_board
  defp state(_, _, true, _, _), do: @win
  defp state(_, _, _, true, _), do: @win
  defp state(_, _, false, false, true), do: @ongoing
  defp state(_, _, false, false, false), do: @draw

  # Rows
  defp win?(<<mark, mark, mark>>, _, _, mark), do: true
  defp win?(_, <<mark, mark, mark>>, _, mark), do: true
  defp win?(_, _, <<mark, mark, mark>>, mark), do: true
  # Columns
  defp win?(<<mark, _, _>>, <<mark, _, _>>, <<mark, _, _>>, mark), do: true
  defp win?(<<_, mark, _>>, <<_, mark, _>>, <<_, mark, _>>, mark), do: true
  defp win?(<<_, _, mark>>, <<_, _, mark>>, <<_, _, mark>>, mark), do: true
  # Diagonals
  defp win?(<<mark, _, _>>, <<_, mark, _>>, <<_, _, mark>>, mark), do: true
  defp win?(<<_, _, mark>>, <<_, mark, _>>, <<mark, _, _>>, mark), do: true
  defp win?(_, _, _, _), do: false
  
end
