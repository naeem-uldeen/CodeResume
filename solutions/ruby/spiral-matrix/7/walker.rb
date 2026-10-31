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

  def turn_right()= directions.next

  def move_to(cell)
    self.row, self.column = cell
  end

  def mark(number)= grid.mark(row, column, number)

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
