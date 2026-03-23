class HighScores

  private

  attr_writer :scores,
              :latest,
              :personal_best,
              :personal_top_three

  def initialize scores
    self.scores = scores
    self.latest = scores.last
    self.personal_best = scores.max
    self.personal_top_three = scores.max 3
  end

  public

  attr_reader :scores,
              :latest,
              :personal_best,
              :personal_top_three

  def latest_is_personal_best?
    latest == personal_best
  end

end
