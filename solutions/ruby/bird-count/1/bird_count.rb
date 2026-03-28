class BirdCount

  LESS_THAN_FIVE = ->(birds) { birds < 5 }
  private_constant :LESS_THAN_FIVE

  def self.last_week = [0, 2, 5, 3, 7, 8, 4]

  private

  attr_accessor :birds_per_day

  def initialize(birds_per_day)=
    self.birds_per_day = birds_per_day

  public

  def yesterday       = birds_per_day[-2]
  def total           = birds_per_day.sum
  def busy_days       = birds_per_day.reject(&LESS_THAN_FIVE).count
  def day_without_birds? = birds_per_day.any?(&:zero?)

end
