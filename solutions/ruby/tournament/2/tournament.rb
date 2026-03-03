class Tournament
  HEADER  = "Team                           | MP |  W |  D |  L |  P"
  COLUMNS = %i[mp wins draws losses points].freeze
  POINTS_PER_OUTCOME = { win: 3, draw: 1, loss: 0 }.freeze

  TeamRecord = Struct.new(:team_name, :matches_played, :wins, :draws, :losses, :points) do
    def self.blank(team_name)
      new(team_name, 0, 0, 0, 0, 0)
    end

    def record_outcome(outcome)
      self.matches_played += 1
      self.points         += POINTS_PER_OUTCOME[outcome]
      case outcome
      when :win  then self.wins   += 1
      when :draw then self.draws  += 1
      when :loss then self.losses += 1
      end
    end

    def <=>(other_team)
      [other_team.points, team_name] <=> [points, other_team.team_name]
    end

    def to_s
      "%-30s | %2d | %2d | %2d | %2d | %2d" % to_a
    end
  end

  RESULT_TO_OUTCOMES = {
    "win"  => [:win,  :loss],
    "loss" => [:loss, :win],
    "draw" => [:draw, :draw]
  }.freeze

  def self.tally(input)
    new(input).scoreboard
  end

  def initialize(input)
    @team_records = Hash.new { |records, team_name| records[team_name] = TeamRecord.blank(team_name) }
    parse_match_results(input)
  end

  def scoreboard
    ([HEADER] + ranked_teams.map(&:to_s)).join("\n") + "\n"
  end

  private

  def parse_match_results(input)
    input.lines.each do |line|
      home_team, away_team, result = line.strip.split(";")
      next unless RESULT_TO_OUTCOMES.key?(result)

      home_outcome, away_outcome = RESULT_TO_OUTCOMES[result]
      @team_records[home_team].record_outcome(home_outcome)
      @team_records[away_team].record_outcome(away_outcome)
    end
  end

  def ranked_teams
    @team_records.values.sort
  end
end