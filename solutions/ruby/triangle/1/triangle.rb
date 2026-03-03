module TriangleValidator

  def valid_triangle?
    return false if sides.any?(&:negative?) || sides.include?(0)

    side1, side2, side3 = sides.sort
    side1 + side2 > side3
  end

end

class Triangle

  include TriangleValidator

  TRIANGLE_TYPES = {
    equilateral: 1,
    isosceles: [1, 2],
    scalene: 3
  }

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
      Array(unique_count_requirement).include?(distinct_sides.size)
    end
  end

end
