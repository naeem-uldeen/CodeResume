require relative 'grid'
require relative 'walker'

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
