class CollatzConjecture
  
  def self.steps(number)
    raise ArgumentError if number <= 0
    
    result = 0
    while number != 1
      number = number.even? ? number / 2 : number * 3 + 1
      result += 1
    end
    result
  end
  
end
