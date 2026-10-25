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
    row.between?(0, size - 1) and
      column.between?(0, size - 1)
  end

  public

  attr_reader :size, :cells

  def capacity
    size**2
  end

  def full?
    filled == capacity
  end

  def open?(row, column)
    in_bounds?(row, column) and
      cells[row][column].zero?
  end

  def mark(row, column, number)
    cells[row][column] = number
    self.filled += 1
  end

end

class Walker

  RIGHT =  [0, 1]
  DOWN  =  [1, 0]
  LEFT  =  [0, -1]
  UP    =  [-1, 0]
  HEADINGS = [RIGHT, DOWN, LEFT, UP]

  private

  attr_accessor :grid, :row, :column, :headings

  def initialize(grid, row = 0, column = 0)
    self.grid = grid
    self.row = row
    self.column = column
    self.headings = HEADINGS.cycle
  end

  # The only method that reads the heading. peek looks at the
  # current heading without consuming it.
  def cell_ahead
    d_row, d_column = headings.peek
    [row + d_row, column + d_column]
  end

  def blocked?(cell)
    not grid.open?(*cell)
  end

  # next consumes the current heading, so peek now yields the
  # one clockwise of it.
  def turn_right
    headings.next
  end

  def move_to(cell)
    self.row, self.column = cell
  end

  def mark(number)
    grid.mark(row, column, number)
  end

  # In a spiral, one right turn is always enough: the cell we just
  # came from is filled, and the cell to our right is open unless
  # the grid is full. So there is nothing to do once it is full.
  def advance
    return if grid.full?
    turn_right if blocked?(cell_ahead)
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
