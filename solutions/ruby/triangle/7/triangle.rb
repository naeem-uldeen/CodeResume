class Triangle

  TYPES_BY_UNIQUE_SIDE_COUNT = {
    equilateral: [1],
    isosceles: [1, 2],
    scalene: [3]
  }.freeze
  private_constant :TYPES_BY_UNIQUE_SIDE_COUNT

  private

  attr_accessor :valid, :distinct_sides

  def initialize sides
    sorted = sides.sort
    self.valid = sorted.take(2).sum > sorted.last
    self.distinct_sides = sides.uniq
  end

  public

  alias valid? valid
  undef valid

  TYPES_BY_UNIQUE_SIDE_COUNT.each do |type, unique_count|
    define_method "#{type}?" do
      valid? && unique_count.include?(distinct_sides.size)
    end
  end

end
