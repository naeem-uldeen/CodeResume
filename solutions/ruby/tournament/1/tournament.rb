class Tournament
  HEADER = "Team                           | MP |  W |  D |  L |  P"
  COLUMNS = %i[mp w d l p].freeze

  def self.tally(input)
    new(input).scoreboard
  end

  def initialize(input)
    @stats = Hash.new { |h, k| h[k] = Hash.new(0) }
    parse_matches(input)
  end

  def scoreboard
    ([HEADER] + sorted_teams.map { |team| format_row(team) }).join("\n") + "\n"
  end

  private

  def parse_matches(input)
    input.lines.each do |line|
      team1, team2, result = line.strip.split(";")
      next unless team1 && team2 && result
      record_result(team1, team2, result)
    end
  end

  def record_result(team1, team2, result)
    @stats[team1][:mp] += 1
    @stats[team2][:mp] += 1

    case result
    when "win"  then award(winner: team1, loser: team2)
    when "loss" then award(winner: team2, loser: team1)
    when "draw" then draw(team1, team2)
    end
  end

  def award(winner:, loser:)
    @stats[winner][:w] += 1
    @stats[winner][:p] += 3
    @stats[loser][:l]  += 1
  end

  def draw(team1, team2)
    [team1, team2].each do |team|
      @stats[team][:d] += 1
      @stats[team][:p] += 1
    end
  end

  def sorted_teams
    @stats.keys.sort_by { |team| [-@stats[team][:p], team] }
  end

  def format_row(team)
    s = @stats[team]
    "%-30s | %2d | %2d | %2d | %2d | %2d" % [team, *s.values_at(*COLUMNS)]
  end
end