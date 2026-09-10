class Triangle

  private

  def initialize count
    @rows = build_rows count
  end

  def build_rows count
    return [] if count.zero?
    previous_rows = build_rows count - 1
    previous_row = previous_rows.last
    previous_rows << next_row(previous_row)
  end

  def next_row previous_row
    if previous_row.nil?
      [1]
    else
      (0...previous_row.size + 1).map do |i|
        left = i.zero? ? 0 : previous_row[i - 1]
        right = previous_row[i] || 0
        left + right
      end
    end
  end

  public

  attr_reader :rows

end
