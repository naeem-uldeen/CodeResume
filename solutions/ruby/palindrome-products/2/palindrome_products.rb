class Palindromes

  Result = Struct.new(:value, :factors)
  private_constant :Result

  private

  attr_writer :smallest, :largest
  attr_reader :min_factor, :max_factor

  def initialize(max_factor:, min_factor: 1)
    raise MinMaxError if min_factor > max_factor

    @min_factor = min_factor
    @max_factor = max_factor
    self.smallest = Result.new(nil, [])
    self.largest  = Result.new(nil, [])
  end

  def palindrome? number
    text = number.to_s
    text == text.reverse
  end

  def update(result, value, factors)
    return Result.new(value, [factors]) if
      result.value.nil? or yield(value, result.value)
    result.factors << factors if value == result.value

    result
  end

  def find_smallest
    min_factor.upto(max_factor) do |a|
      break if smallest.value and a * a > smallest.value

      a.upto(max_factor) do |b|
        product = a * b
        break if smallest.value and product > smallest.value

        next unless palindrome? product
        self.smallest = update(smallest, product, [a, b]) {
          |new_value, old_value| new_value < old_value
        }
      end
    end
  end

  def find_largest
    max_factor.downto(min_factor) do |a|
      break if largest.value and a * max_factor < largest.value

      max_factor.downto(a) do |b|
        product = a * b
        break if largest.value and product < largest.value

        next unless palindrome?(product)
        self.largest = update(largest, product, [a, b]) {
          |new_value, old_value| new_value > old_value
        }
      end
    end
  end

  public

  attr_reader :smallest, :largest

  def generate
    find_smallest
    find_largest
  end

end

class MinMaxError < ArgumentError
  def initialize message = 'min must be <= max'
    super
  end
end
