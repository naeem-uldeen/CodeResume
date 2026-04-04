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
    self.digits = number.to_s.each_char.map &:to_i
    self.length = digits.size
  end

  def armstrong_sum
    digits.sum { |digit| digit**length }
  end

  public

  def narcissistic?
    armstrong_sum == number
  end

end
