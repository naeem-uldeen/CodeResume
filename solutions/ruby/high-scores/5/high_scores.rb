class HighScores

  private

  attr_writer :scores,
              :latest,
              :personal_best,
              :personal_top_three,
              :latest_is_personal_best

  def initialize scores
    self.scores = scores
    self.latest = scores.last
    self.personal_best = scores.max
    self.personal_top_three = scores.max 3
    self.latest_is_personal_best = latest == personal_best
  end

  public

  attr_reader :scores,
              :latest,
              :personal_best,
              :personal_top_three,
              :latest_is_personal_best

  alias latest_is_personal_best? latest_is_personal_best
  undef latest_is_personal_best

end
