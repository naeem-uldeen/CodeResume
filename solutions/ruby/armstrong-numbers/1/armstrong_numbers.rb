class ArmstrongNumbers

  def self.include? number
    new(number).narcissistic?
  end

  private

  attr_accessor :number,
                :digits,
                :length

  def initialize number
    self.number = number
    self.digits = number.to_s.chars
    self.length = self.digits.size
  end

  def armstrong_sum
    digits.map do |digit|
      digit.to_i ** length
    end.sum
  end

  public

  def narcissistic?
    armstrong_sum == number
  end

end
