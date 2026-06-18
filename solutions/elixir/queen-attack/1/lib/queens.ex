defmodule Queens do

  @board_size 8
  @valid_queens [:white, :black]
  @valid_range 0..(@board_size - 1)
  defstruct @valid_queens

  def new(position \\ []) do
    if Enum.any?(Keyword.keys(position), &(&1 not in @valid_queens)), do: raise ArgumentError
    {white, black} = {Keyword.get(position, :white), Keyword.get(position, :black)}
    validate_positions!(white, black)
    %Queens{white: white, black: black}
  end

  defp valid_position?(nil), do: true
  defp valid_position?({row, col}), do: row in @valid_range and col in @valid_range
  
  defp validate_positions!(white, black) do
    unless valid_position?(white) and valid_position?(black), do: raise ArgumentError
    if white && white == black, do: raise ArgumentError
  end

  def to_string(%Queens{white: white_position, black: black_position}) do
    queen_positions =
      for {position, symbol} <- [{white_position, "W"}, {black_position, "B"}],
          position != nil,
          into: %{},
          do: {position, symbol}

    Enum.map_join(0..(@board_size - 1), "\n", fn row ->
      Enum.map_join(0..(@board_size - 1), " ", fn col ->
        Map.get(queen_positions, {row, col}, "_")
      end)
    end)
  end

  def can_attack?(%Queens{white: nil, black: _}), do: false
  def can_attack?(%Queens{white: _, black: nil}), do: false
  def can_attack?(%Queens{white: {white_row, white_col}, black: {black_row, black_col}}), do:
    white_row == black_row or white_col == black_col or abs(white_row - black_row) == abs(white_col - black_col)
    
end

