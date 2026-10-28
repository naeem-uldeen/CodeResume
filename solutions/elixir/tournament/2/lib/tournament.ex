defmodule Tournament do
  @header "Team                           | MP |  W |  D |  L |  P"
  @blank  %{mp: 0, w: 0, d: 0, l: 0, p: 0}

  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
    rows =
      input
      |> Enum.reduce(%{}, &parse_line/2)
      |> Enum.sort_by(fn {team, stats} -> {-stats.p, team} end)
      |> Enum.map(&format_row/1)

    Enum.join([@header | rows], "\n")
  end

  defp parse_line(line, teams) do
    case String.split(line, ";") do
      [a, b, "win"]  -> teams |> record(a, :win) |> record(b, :loss)
      [b, a, "loss"] -> teams |> record(a, :win) |> record(b, :loss)
      [a, b, "draw"] -> teams |> record(a, :draw) |> record(b, :draw)
      _              -> teams
    end
  end

  defp record(teams, team, result),
    do: Map.update(teams, team, apply_result(@blank, result), &apply_result(&1, result))

  defp apply_result(s, :win),  do: %{s | mp: s.mp + 1, w: s.w + 1, p: s.p + 3}
  defp apply_result(s, :draw), do: %{s | mp: s.mp + 1, d: s.d + 1, p: s.p + 1}
  defp apply_result(s, :loss), do: %{s | mp: s.mp + 1, l: s.l + 1}

  defp format_row({team, %{mp: mp, w: w, d: d, l: l, p: p}}),
    do:
      ~c"~-30ts | ~2B | ~2B | ~2B | ~2B | ~2B"
      |> :io_lib.format([String.to_charlist(team), mp, w, d, l, p])
      |> List.to_string()
end
