class SumOfMultiples

  MULTIPLE_OF = ->(factors, number) do
    factors.any? { |factor|
      factor.zero? ? false : number.modulo(factor).zero?
    }
  end

  private

  attr_accessor :factors

  def initialize(*factors)
    self.factors = factors
  end

  public

  def to(upper_bound)
    (0...upper_bound).sum do |number|
      MULTIPLE_OF.(factors, number) ? number : 0
    end
  end

end
