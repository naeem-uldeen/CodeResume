class CollatzConjecture

  def self.steps number
    raise ArgumentError if number <= 0

    result = 0

    while number != 1
      # divide by two if even, otherwise multiply by three and add one
      number = number.even? ? number / 2 : number * 3 + 1
      result += 1
    end

    result
  end

end
