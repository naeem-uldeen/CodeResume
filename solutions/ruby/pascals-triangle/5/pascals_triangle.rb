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
    if previous_row
      (0...previous_row.size + 1).map do |i|
        left = i.zero? ? 0 : previous_row[i - 1]
        right = previous_row[i] || 0
        left + right
      end
    else
      [1]
    end
  end

  public

  attr_reader :rows

end
