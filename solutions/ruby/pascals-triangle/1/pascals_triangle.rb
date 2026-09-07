class Triangle

  attr_reader :rows

  def initialize(count)
    @rows = (0...count).reduce([]) do |rows, row_index|
      previous_row = rows.last
      row =
        if previous_row.nil?
          [1]
        else
          (0..row_index).map do |i|
            left = i.zero? ? 0 : previous_row[i - 1]
            right = previous_row[i] || 0
            left + right
          end
        end

      rows << row
    end
  end

end
