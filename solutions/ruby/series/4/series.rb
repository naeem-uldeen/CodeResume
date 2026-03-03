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
    raise EmptySeriesError if series.empty?
    self.series = series
    self.length = series.length
  end

  public

  def slices requested_size
    raise SliceSizeError if requested_size > length
    series.chars.each_cons(requested_size).map(&:join)
  end

end
