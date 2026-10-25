class Grid

  private

  attr_writer :size, :cells

  def initialize(size)
    self.size = size
    self.cells = Array.new(size) { Array.new(size, 0) }
  end

  def in_bounds?(row, column)
    row.between?(0, size - 1) and
      column.between?(0, size - 1)
  end

  public

  attr_reader :size, :cells

  def open?(row, column)
    in_bounds?(row, column) and
      cells[row][column].zero?
  end

  def mark(row, column, number)
    cells[row][column] = number
  end

end

class Walker

  RIGHT =  [0, 1]
  DOWN  =  [1, 0]
  LEFT  =  [0, -1]
  UP    =  [-1, 0]
  HEADINGS = [RIGHT, DOWN, LEFT, UP]

  private

  attr_accessor :grid, :row, :column, :heading

  def initialize(grid, row = 0, column = 0)
    self.grid = grid
    self.row = row
    self.column = column
    self.heading = 0
  end

  def cell_ahead
    d_row, d_column = HEADINGS[heading]
    [row + d_row, column + d_column]
  end

  def blocked_ahead?
    true unless grid.open?(*cell_ahead)
  end

  def turn_right
    self.heading = (heading + 1) % HEADINGS.length
  end

  def step
    self.row, self.column = cell_ahead
  end

  def mark(number)
    grid.mark(row, column, number)
  end

  public

  def walk_spiral
    (1..grid.size**2).each do |number|
      mark(number)
      turn_right if blocked_ahead?
      step
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
