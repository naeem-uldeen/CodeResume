class Grid

  private

  attr_accessor :filled
  attr_writer :size, :cells

  def initialize(size)
    self.size = size
    self.cells = Array.new(size) { Array.new(size, 0) }
    self.filled = 0
  end

  def in_bounds?(row, column)
    row.between?(0, size - 1) &&
      column.between?(0, size - 1)
  end

  public

  attr_reader :size, :cells

  def capacity
    @capacity ||= size**2
  end

  def full?
    filled == capacity
  end

  def open?(row, column)
    in_bounds?(row, column) &&
      cells[row][column].zero?
  end

  def mark(row, column, number)
    cells[row][column] = number
    self.filled += 1
  end

end

class Walker

  DIRECTIONS = {
    right: [0, 1],
    down:  [1, 0],
    left:  [0, -1],
    up:    [-1, 0]
  }

  private

  attr_accessor :grid, :row, :column, :directions

  def initialize(grid, row = 0, column = 0)
    self.grid = grid
    self.row = row
    self.column = column
    self.directions = DIRECTIONS.keys.cycle
  end

  def cell_ahead
    row_offset, column_offset = DIRECTIONS.fetch(directions.peek)
    [row + row_offset, column + column_offset]
  end

  def blocked_ahead?
    true unless grid.open?(*cell_ahead)
  end

  def turn_right
    directions.next
  end

  def move_to(cell)
    self.row, self.column = cell
  end

  def mark(number)
    grid.mark(row, column, number)
  end

  def advance
    return if grid.full?

    turn_right if blocked_ahead?
    move_to(cell_ahead)
  end

  public

  def walk_spiral
    number = 1

    until grid.full?
      mark(number)
      number += 1
      advance
    end
  end

end

class SpiralMatrix

  private

  attr_writer :matrix

  def initialize(size)
    grid = Grid.new(size)
    Walker.new(grid).walk_spiral
    self.matrix = grid.cells
  end

  public

  attr_reader :matrix

end
