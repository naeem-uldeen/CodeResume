# == Spiral Matrix Generator ==
#
# THE CORE IDEA: Shrinking Boundaries
#
# We maintain four pointers that mark the current "walls" of the
# unvisited region of the matrix:
#
#   top    — first unvisited row
#   bottom — last unvisited row
#   left   — first unvisited column
#   right  — last unvisited column
#
# Numbers are written in spiral order: right, down, left, up,
# tracked by a direction counter (0-3) that rotates clockwise.
#
# Each pass of the loop peels off one "side" of the current ring:
# after walking a row or column, that boundary is "used up",
# so we shrink it inward before continuing:
#
#   direction 0 (right) → walk top row,    then top += 1
#   direction 1 (down)  → walk right col,  then right -= 1
#   direction 2 (left)  → walk bottom row,  then bottom -= 1
#   direction 3 (up)    → walk left col,   then left += 1
#
# The loop continues while there are still numbers to place
# (1..size*size), stopping when the walls cross in the center.
#
# Time complexity:  O(n²) — each cell is written exactly once
# Space complexity: O(1) extra — only four boundary pointers

class SpiralMatrix

  attr_reader :matrix

  def initialize(size)
    @matrix = Array.new(size) { Array.new(size, 0) }
    fill_spiral(size)
  end

  def fill_spiral(size)
    number = 1
    top = 0
    bottom = size - 1
    left = 0
    right = size - 1
    direction = 0

    while number <= size * size
      if direction == 0
        left.upto(right) do |i|
          @matrix[top][i] = number
          number += 1
        end
        top += 1

      elsif direction == 1
        top.upto(bottom) do |i|
          @matrix[i][right] = number
          number += 1
        end
        right -= 1

      elsif direction == 2
        right.downto(left) do |i|
          @matrix[bottom][i] = number
          number += 1
        end
        bottom -= 1

      elsif direction == 3
        bottom.downto(top) do |i|
          @matrix[i][left] = number
          number += 1
        end
        left += 1
      end

      direction = (direction + 1) % 4
    end

  end

end
