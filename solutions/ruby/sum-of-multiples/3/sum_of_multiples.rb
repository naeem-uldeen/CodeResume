class SumOfMultiples

  MULTIPLE_OF = -> factors, number do
    factors.any? do |factor| factor.nonzero? &&
      number.modulo(factor).zero?
    end
  end
  private_constant :MULTIPLE_OF

  private

  attr_accessor :factors

  def initialize *factors
    self.factors = factors
  end

  public

  def to upper_bound
    upper_bound.times.sum do |number|
      MULTIPLE_OF.(factors, number) ? number : 0
    end
  end

end
