class Triangle

  FIRST_ROW = [1]
  private_constant :FIRST_ROW

  private

  attr_writer :rows

  def initialize count
    self.rows = build_rows count
  end

  def build_rows count
    return [] if count.zero?

    (count - 1).times.reduce([FIRST_ROW]) do |rows, _|
      rows << next_row(rows.last)
    end
  end

  def next_row previous_row
    return [1] unless previous_row

    [0, *previous_row, 0].each_cons(2).map(&:sum)
  end

  public

  attr_reader :rows

end
