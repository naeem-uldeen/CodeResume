class Palindromes

  Result = Struct.new(:value, :factors)
  private_constant :Result

  attr_accessor :smallest, :largest
  private :smallest=, :largest=

  def generate
    find_smallest
    find_largest
  end

  private

  attr_accessor :min_factor, :max_factor

  def initialize(max_factor:, min_factor: 1)
    raise MinMaxError if min_factor > max_factor

    self.min_factor = min_factor
    self.max_factor = max_factor
    self.smallest = Result.new(nil, [])
    self.largest  = Result.new(nil, [])
  end

  def palindrome?(number)
    text = number.to_s
    text == text.reverse
  end

  def update(result, value, factors)
    return Result.new(value, [factors]) if
      !result.value or yield(value, result.value)

    result.factors << factors if value == result.value
    result
  end

  def find_smallest
    min_factor.upto(max_factor) do |smaller_factor|
      break if smallest.value and smaller_factor * smaller_factor > smallest.value

      smaller_factor.upto(max_factor) do |larger_factor|
        product = smaller_factor * larger_factor
        break if smallest.value and product > smallest.value

        next unless palindrome? product
        self.smallest = update(smallest, product, [smaller_factor, larger_factor]) {
          |new_value, old_value| new_value < old_value
        }
      end
    end
  end

  def find_largest
    max_factor.downto(min_factor) do |smaller_factor|
      break if largest.value and smaller_factor * max_factor < largest.value

      max_factor.downto(smaller_factor) do |larger_factor|
        product = smaller_factor * larger_factor
        break if largest.value and product < largest.value

        next unless palindrome? product
        self.largest = update(largest, product, [smaller_factor, larger_factor]) {
          |new_value, old_value| new_value > old_value
        }
      end
    end
  end

end

class MinMaxError < ArgumentError
  def initialize message = 'min must be <= max'
    super
  end
end
