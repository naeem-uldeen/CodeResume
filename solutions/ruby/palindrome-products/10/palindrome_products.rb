class Palindromes

  PalindromeMatch = Struct.new(:value, :factors)
  private_constant :PalindromeMatch

  build_strategy = ->(range_method, compare_op) {
    make_range = ->(from, to) {
      lo, hi = [from, to].sort
      range_method == :upto ? lo.send(range_method, hi) : hi.send(range_method, lo)
    }
    better = ->(candidate, incumbent) { candidate.send(compare_op, incumbent) }
    [make_range, better]
  }

  RANGE_COMPARISON_STRATEGIES = {
    smallest: build_strategy.call(:upto,   :<),
    largest:  build_strategy.call(:downto, :>)
  }
  private_constant :RANGE_COMPARISON_STRATEGIES

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

  def update(best, value, factors)
    return PalindromeMatch.new(value, [factors]) if
      not best.value or yield(value, best.value)

    best.factors << factors if value == best.value
    best
  end

  def find_extreme order
    make_range, better = RANGE_COMPARISON_STRATEGIES[order]
    best = PalindromeMatch.new(nil, [])

    make_range.call(min_factor, max_factor).each do |first_factor|
      second_factor_range = make_range.call(first_factor, max_factor)
      break if best.value and better.call(best.value, first_factor * second_factor_range.first)

      second_factor_range.each do |second_factor|
        product = first_factor * second_factor
        break if best.value and better.call(best.value, product)

        next unless palindrome? product
        best = update(best, product, [first_factor, second_factor], &better)
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
