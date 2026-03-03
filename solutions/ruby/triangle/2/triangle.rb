module TriangleValidator
  def valid_triangle?
    side_a, side_b, side_c = sides.sort
    side_a + side_b > side_c
  end
end

class Triangle

  include TriangleValidator

  TRIANGLE_TYPES = {
    equilateral: [1],
    isosceles: [1, 2],
    scalene: [3]
  }.freeze

  private

  attr_accessor :sides, :distinct_sides

  def initialize sides
    self.sides = sides
    self.distinct_sides = sides.uniq
  end

  public

  TRIANGLE_TYPES.each do |type, unique_count_requirement|
    define_method "#{type}?" do
      return false unless valid_triangle?
      unique_count_requirement.include? distinct_sides.size
    end
  end

end
