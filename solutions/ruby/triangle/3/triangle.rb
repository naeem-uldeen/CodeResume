class Triangle

  TRIANGLE_TYPES = {
    equilateral: [1],
    isosceles: [1, 2],
    scalene: [3]
  }.freeze

  private

  attr_accessor :valid, :distinct_sides

  def initialize sides
    side_a, side_b, side_c = sides.sort
    self.valid = side_a + side_b > side_c
    self.distinct_sides = sides.uniq.freeze
  end

  public

  TRIANGLE_TYPES.each do |type, unique_count|
    define_method "#{type}?" do
      self.valid and
        unique_count.include? self.distinct_sides.size
    end
  end

end
