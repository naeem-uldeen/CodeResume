class Palindromes

  Result = Struct.new(:value, :factors)
  private_constant :Result

  private

  attr_writer :smallest, :largest
  attr_reader :min_factor, :max_factor

  def initialize(max_factor:, min_factor: 1)
    raise ArgumentError, 'min must be <= max' if
      min_factor > max_factor

    @min_factor = min_factor
    @max_factor = max_factor
    self.smallest = Result.new(nil, [])
    self.largest  = Result.new(nil, [])
  end

  def palindrome? number
    text = number.to_s
    text == text.reverse
  end

  def update_smallest(value, factors)
    if smallest.value.nil? or value < smallest.value
      self.smallest = Result.new(value, [factors])
    elsif value == smallest.value
      smallest.factors << factors
    end
  end

  def update_largest(value, factors)
    if largest.value.nil? or value > largest.value
      self.largest = Result.new(value, [factors])
    elsif value == largest.value
      largest.factors << factors
    end
  end

  def find_smallest
    min_factor.upto(max_factor) do |a|
      break if smallest.value and a * a > smallest.value

      a.upto(max_factor) do |b|
        product = a * b
        break if smallest.value && product > smallest.value

        update_smallest(product, [a, b]) if palindrome?(product)
      end
    end
  end

  def find_largest
    max_factor.downto(min_factor) do |a|
      break if largest.value and a * max_factor < largest.value

      max_factor.downto(a) do |b|
        product = a * b
        break if largest.value and product < largest.value

        update_largest(product, [a, b]) if palindrome?(product)
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
