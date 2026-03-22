class Raindrops

  DROPS = {
    3 => 'Pling',
    5 => 'Plang',
    7 => 'Plong'
  }
  private_constant :DROPS

  def self.convert number
    new(number).sound
  end

  private

  attr_accessor :number

  def initialize number
    self.number = number
  end

  def generate_sound
    DROPS.select { |factor, _| number % factor == 0 }
      .values
      .inject(:+) or number.to_s
  end

  public

  def sound
    # memoized
    sound ||= generate_sound
  end

end
