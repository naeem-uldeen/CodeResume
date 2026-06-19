defmodule Queens do

  @valid_indices 0..7
  defstruct [:white, :black]

  def new(position \\ []) do
    with true <- Enum.all?(Keyword.keys(position), &(&1 in [:white, :black])),
         white <- Keyword.get(position, :white),
         black <- Keyword.get(position, :black),
         true <- valid_position?(white),
         true <- valid_position?(black),
         true <- distinct_positions?(white, black) do
      %Queens{white: white, black: black}
    else
      _ -> raise ArgumentError, "invalid queen position"
    end
  end

  defp valid_position?(nil), do: true
  defp valid_position?({row, col}), do: row in @valid_indices and col in @valid_indices

  defp distinct_positions?(nil, _black), do: true
  defp distinct_positions?(white, black), do: white != black

  def to_string(%Queens{white: white_position, black: black_position}) do
    Enum.map_join(@valid_indices, "\n", fn row ->
      Enum.map_join(@valid_indices, " ", fn col ->
        symbol_at({row, col}, white_position, black_position)
      end)
    end)
  end

  defp symbol_at(position, white_position, _black_position) when position == white_position, do: "W"
  defp symbol_at(position, _white_position, black_position) when position == black_position, do: "B"
  defp symbol_at(_position, _white_position, _black_position), do: "_"

  def can_attack?(%Queens{white: {row, _}, black: {row, _}}), do: true
  def can_attack?(%Queens{white: {_, col}, black: {_, col}}), do: true
  def can_attack?(%Queens{white: {wr, wc}, black: {br, bc}}) when abs(wr - br) == abs(wc - bc), do: true
  def can_attack?(_), do: false
  
end
