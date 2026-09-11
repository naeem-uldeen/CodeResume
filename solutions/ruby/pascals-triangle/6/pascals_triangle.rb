class Triangle

  private

  attr_writer :rows

  def initialize count
    self.rows = build_rows count
  end

  def build_rows count
    return [] if count.zero?

    previous_rows = build_rows count - 1
    previous_row = previous_rows.last
    previous_rows << next_row(previous_row)
  end

  def next_row previous_row
    return [1] unless previous_row

    [0, *previous_row, 0].each_cons(2).map(&:sum)
  end

  public

  attr_reader :rows

end
