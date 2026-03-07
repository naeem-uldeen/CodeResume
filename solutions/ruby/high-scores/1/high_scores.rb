class HighScores

  private

  def initialize(scores)
    self.scores = scores
  end

  attr_writer :scores

  public
  
  def latest
    scores.last
  end

  def personal_best
    scores.max
  end

  def personal_top_three
    scores.max 3
  end

  def latest_is_personal_best?
    latest == personal_best
  end

  attr_reader :scores
  
end
