class Palindromes

  PalindromeMatch = Struct.new(:value, :factors)

  BUILD_RANGE = ->(range_method) {
    ->(from, to) {
      lo, hi = [from, to].sort
      range_method == :upto ?
        lo.send(range_method, hi) :
        hi.send(range_method, lo)
    }
  }

  RANGE_COMPARISON_STRATEGIES = {
    smallest: [BUILD_RANGE.call(:upto),   :<],
    largest:  [BUILD_RANGE.call(:downto), :>]
  }
  private_constant :PalindromeMatch,
                   :BUILD_RANGE,
                   :RANGE_COMPARISON_STRATEGIES

  private

  attr_writer   :smallest,   :largest
  attr_accessor :min_factor, :max_factor

  def initialize(max_factor:, min_factor: 1)
    raise MinMaxError if min_factor > max_factor

    self.min_factor = min_factor
    self.max_factor = max_factor
    self.smallest = find_extreme :smallest
    self.largest = find_extreme  :largest
  end

  def palindrome? number
    text = number.to_s
    text == text.reverse
  end

  def update(best, value, factors, compare_op)
    return PalindromeMatch.new(value, [factors]) if
      not best.value or value.send(compare_op, best.value)

    best.factors << factors if value == best.value
    best
  end

  def find_extreme order
    make_range, compare_op = RANGE_COMPARISON_STRATEGIES[order]
    best = PalindromeMatch.new(nil, [])

    make_range.call(min_factor, max_factor).each do |first_factor|
      second_factor_range = make_range.call(first_factor, max_factor)
      break if best.value and best.value.send(compare_op, first_factor * second_factor_range.first)

      second_factor_range.each do |second_factor|
        product = first_factor * second_factor
        break if best.value and best.value.send(compare_op, product)

        next unless palindrome? product
        best = update(best, product, [first_factor, second_factor], compare_op)
      end
    end

    best
  end

  public

  attr_reader :smallest, :largest

  def generate
  end

end

class MinMaxError < ArgumentError
  def initialize message = 'min must be <= max'
    super
  end
end
