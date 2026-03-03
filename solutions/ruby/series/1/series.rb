class Series

  def initialize series
    raise ArgumentError if series.empty?
    @series = series
    @length = series.length
  end

  def slices n
    raise ArgumentError if n > @length
    @series.chars.each_cons(n).map &:join
  end

end
