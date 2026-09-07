class Triangle
  
  attr_accessor :rows

  def initialize(count)
    self.rows = build_rows(count)
  end

  private

  def build_rows(count)
    return [] if count.zero?
    previous_rows = build_rows(count - 1)
    previous_row = previous_rows.last

    next_row =
      if previous_row.nil?
        [1]
      else
        (0...previous_row.size + 1).map do |i|
          left = i.zero? ? 0 : previous_row[i - 1]
          right = previous_row[i] || 0
          left + right
        end
      end

    previous_rows + [next_row]
  end
  
end
