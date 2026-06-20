defmodule Queens do

  @valid_indices 0..7
  @err_invalid_key   "invalid queen position"
  @err_white         "invalid position of white"
  @err_black         "invalid position of black"
  @err_same_position "black and white have the same position"

  defstruct [:white, :black]

  def new(position \\ []) do
    with true <- Enum.all?(Keyword.keys(position), &(&1 in [:white, :black])) ||
      raise(ArgumentError, @err_invalid_key),
         white = Keyword.get(position, :white),
         black = Keyword.get(position, :black),
         true <- valid_position?(white) || raise(ArgumentError, @err_white),
         true <- valid_position?(black) || raise(ArgumentError, @err_black),
         true <- distinct_positions?(white, black) || raise(ArgumentError, @err_same_position) do
      %Queens{white: white, black: black}
    end
  end

  defp valid_position?(nil), do: true
  defp valid_position?({row, col}), do: row in @valid_indices and col in @valid_indices

  defp distinct_positions?(white, black), do: white != black

  def to_string(%Queens{white: white_position, black: black_position}) do
    Enum.map_join(@valid_indices, "\n", fn row ->
      Enum.map_join(@valid_indices, " ", fn col ->
        case {row, col} do
          ^black_position -> "B"
          ^white_position -> "W"
          _ -> "_"
        end
      end)
    end)
  end

  def can_attack?(%Queens{white: {row, _}, black: {row, _}}), do: true
  def can_attack?(%Queens{white: {_, col}, black: {_, col}}), do: true
  def can_attack?(%Queens{white: {wr, wc}, black: {br, bc}}) when abs(wr - br) == abs(wc - bc), do: true
  def can_attack?(_), do: false

end
