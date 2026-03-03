class Series

  private

  attr_reader :series, :length

  def initialize series
    raise ArgumentError if series.empty?
    @series = series
    @length = series.length
  end

  public

  def slices n
    raise ArgumentError if n > length
    series.chars.each_cons(n).map(&:join)
  end

end
