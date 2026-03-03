class CollatzConjecture
  
  def self.steps(number)
    raise ArgumentError if number <= 0
    
    result = 0
    
    while number != 1
      if number.even?
        number /= 2
      else
        number = number * 3 + 1
      end
      result += 1
    end
    result
  end
  
end
