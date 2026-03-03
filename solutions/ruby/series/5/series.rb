module SeriesExceptions

  class EmptySeriesError < ArgumentError
    def initialize(message = 'Series cannot be empty - provide at least one digit')
      super
    end
  end

  class SliceSizeError < ArgumentError
    def initialize(message = 'Requested slice size exceeds series length')
      super
    end
  end

end


class Series
  include SeriesExceptions

  private

  attr_accessor :series, :length

  def initialize series
    series.empty? and raise EmptySeriesError
    self.series = series
    self.length = series.length
  end

  public

  def slices requested_size
    requested_size > length and raise SliceSizeError
    series.chars.each_cons(requested_size).map(&:join)
  end

end
