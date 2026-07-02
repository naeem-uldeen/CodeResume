defmodule StateOfTicTacToe do

  def game_state(<<row1::binary-size(3), "\n", row2::binary-size(3), "\n", row3::binary-size(3), "\n">>) do
    do_game_state(row1, row2, row3)
  end

  defp do_game_state(row1, row2, row3) do
    cells = <<row1::binary, row2::binary, row3::binary>>
    {x_count, o_count} = count_marks(cells, 0, 0)
    x_wins = win?(row1, row2, row3, ?X)
    o_wins = win?(row1, row2, row3, ?O)

    state(x_count, o_count, x_wins, o_wins, cells)
  end

  defp count_marks(<<>>, x, o), do: {x, o}
  defp count_marks(<<?X, rem::binary>>, x, o), do: count_marks(rem, x + 1, o)
  defp count_marks(<<?O, rem::binary>>, x, o), do: count_marks(rem, x, o + 1)
  defp count_marks(<<_, rem::binary>>, x, o), do: count_marks(rem, x, o)

  defp state(x, o, _, _, _) when o > x, do: {:error, "Wrong turn order: O started"}
  defp state(x, o, _, _, _) when x > o + 1, do: {:error, "Wrong turn order: X went twice"}
  defp state(_, _, true, true, _), do: {:error, "Impossible board: game should have ended after the game was won"}
  defp state(x, o, true, false, _) when x != o + 1, do: {:error, "Impossible board: game should have ended after the game was won"}
  defp state(x, o, false, true, _) when x != o, do: {:error, "Impossible board: game should have ended after the game was won"}
  defp state(_, _, true, _, _), do: {:ok, :win}
  defp state(_, _, _, true, _), do: {:ok, :win}
  defp state(_, _, false, false, cells) do
    if blank?(cells) do
      {:ok, :ongoing}
    else
      {:ok, :draw}
    end
  end

  defp blank?(<<".", _::binary>>), do: true
  defp blank?(<<_, rem::binary>>), do: blank?(rem)
  defp blank?(<<>>), do: false

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
