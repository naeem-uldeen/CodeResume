class BirdCount

  LESS_THAN_FIVE = ->(birds) { birds < 5 }
  private_constant :LESS_THAN_FIVE

  def self.last_week = [0, 2, 5, 3, 7, 8, 4]

  private

  attr_writer :birds_per_day,
              :yesterday,
              :total,
              :busy_days,
              :day_without_birds

  def initialize birds_per_day
    self.birds_per_day = birds_per_day.freeze
    self.yesterday = birds_per_day[-2]
    self.total = birds_per_day.sum
    self.busy_days = birds_per_day.reject(&LESS_THAN_FIVE).count
    self.day_without_birds = birds_per_day.any?(&:zero?)
  end

  public

  attr_reader :birds_per_day,
              :yesterday,
              :total,
              :busy_days,
              :day_without_birds

  alias day_without_birds? day_without_birds
  undef day_without_birds

end
