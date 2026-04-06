class Darts

  def self.score x, y
    new(x, y).score
  end

  private

  attr_accessor :x, :y

  def initialize x, y
    self.x, self.y = x, y
  end

  def distance_from_center
    Math.hypot x, y
  end

  def calculate_impact_region
    distance = distance_from_center
    return :miss          if distance > 10
    return :bullseye      if distance <= 1
    return :inner_circle  if distance <= 5
    :middle_circle
  end

  public

  def score
    case calculate_impact_region
    when :bullseye      then 10
    when :inner_circle  then 5
    when :middle_circle then 1
    else 0
    end
  end

end
