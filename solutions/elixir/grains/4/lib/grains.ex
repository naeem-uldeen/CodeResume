defmodule Grains do
  import Bitwise, only: [<<<: 2]

  @total_chessboard_squares 64
  @square_error_message "The requested square must be between 1 and " <>
                        "#{@total_chessboard_squares} (inclusive)"

  def square(n) when n in 1..@total_chessboard_squares,
    do: {:ok, 1 <<< (n - 1)}
  def square(_), do: {:error, @square_error_message}

  def total, do: {:ok, (1 <<< @total_chessboard_squares) - 1}

end
