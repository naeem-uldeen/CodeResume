class Grid

  private

  attr_accessor :filled
  attr_writer :size, :cells, :capacity

  def initialize(size)
    self.size = size
    self.capacity = size**2
    self.cells = Array.new(size) { Array.new(size, 0) }
    self.filled = 0
  end

  def in_bounds?(row, column)
    row.between?(0, size - 1) and
      column.between?(0, size - 1)
  end

  public

  attr_reader :size, :cells, :capacity

  def full?()= filled == capacity

  def open?(row, column)
    in_bounds?(row, column) and
      cells[row][column].zero?
  end

  def mark(row, column, number)
    cells[row][column] = number
    self.filled += 1
  end

end
