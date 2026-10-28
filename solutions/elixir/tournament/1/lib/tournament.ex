defmodule Tournament do
  @header "Team                           | MP |  W |  D |  L |  P"

  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
    teams = input|> Enum.reduce(%{}, &parse_line/2)
    rows = teams|> Enum.sort_by(fn {team, stats} -> {-stats.p, team} end)|> Enum.map(&format_row/1)
    Enum.join([@header | rows], "\n")
  end

  defp parse_line(line, teams) do
    case String.split(line, ";") do
      [team_a, team_b, "win"]  -> teams |> record(team_a, 3, 1, 0, 0) |> record(team_b, 0, 0, 0, 1)
      [team_a, team_b, "loss"] -> teams |> record(team_a, 0, 0, 0, 1) |> record(team_b, 3, 1, 0, 0)
      [team_a, team_b, "draw"] -> teams |> record(team_a, 1, 0, 1, 0) |> record(team_b, 1, 0, 1, 0)
      _ -> teams
    end
  end

  defp record(teams, team, pts, wins, draws, losses) do
    Map.update(teams, team, %{mp: 1, w: wins, d: draws, l: losses, p: pts}, fn stats ->
      %{
        mp: stats.mp + 1,
        w:  stats.w + wins,
        d:  stats.d + draws,
        l:  stats.l + losses,
        p:  stats.p + pts
      }
    end)
  end

  defp format_row({team, %{mp: mp, w: w, d: d, l: l, p: p}}) do
    ~c"~-30s | ~2B | ~2B | ~2B | ~2B | ~2B"
    |> :io_lib.format([String.to_charlist(team), mp, w, d, l, p])
    |> List.to_string()
  end
end
