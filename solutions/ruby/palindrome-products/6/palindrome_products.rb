class Palindromes

  Result = Struct.new(:value, :factors)
  private_constant :Result

  private

  attr_writer   :smallest,   :largest
  attr_accessor :min_factor, :max_factor

  def initialize(max_factor:, min_factor: 1)
    raise MinMaxError if min_factor > max_factor

    self.min_factor = min_factor
    self.max_factor = max_factor
    self.smallest = find_extreme :smallest
    self.largest  = find_extreme :largest
  end

  def palindrome? number
    text = number.to_s
    text == text.reverse
  end

  def update(result, value, factors)
    return Result.new(value, [factors]) if
      not result.value or yield(value, result.value)

    result.factors << factors if value == result.value
    result
  end

  def find_extreme order
    ascending = order == :smallest
    result = Result.new(nil, [])
    outer  = ascending ? min_factor.upto(max_factor) : max_factor.downto(min_factor)
    better = ascending ? ->(new_value, old_value) { new_value < old_value }
                        : ->(new_value, old_value) { new_value > old_value }

    outer.each do |smaller_factor|
      inner = ascending ? smaller_factor.upto(max_factor) : max_factor.downto(smaller_factor)
      break if result.value and better.call(result.value, smaller_factor * inner.first)

      inner.each do |larger_factor|
        product = smaller_factor * larger_factor
        break if result.value and better.call(result.value, product)

        next unless palindrome? product
        result = update(result, product, [smaller_factor, larger_factor], &better)
      end
    end

    result
  end

  public

  attr_reader :smallest, :largest

  # No-op vestigial: computation moved to initialize
  def generate
  end

end

class MinMaxError < ArgumentError
  def initialize message = 'min must be <= max'
    super
  end
end
