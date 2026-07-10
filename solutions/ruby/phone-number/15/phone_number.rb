class PhoneNumber
  
  module Errors
    Length      = Class.new(ArgumentError)
    CountryCode = Class.new(ArgumentError)
    AreaCode    = Class.new(ArgumentError)
    Exchange    = Class.new(ArgumentError)
    ALL = [Length, CountryCode, AreaCode, Exchange]
  end
  
  Slice = Struct.new(:start, :slice_length) do
    def of(string)
      string.slice(start, slice_length)
    end
  end
  
  NANP = NORTH_AMERICAN_NUMBERING_PLAN = {
    country:  Slice.new(-11, 1),
    area:     Slice.new(-10, 3),
    exchange: Slice.new(-7, 3),
    line:     Slice.new(-4, 4)
  }
  DIGITS = /\d/
  VALID_CODE_START = /[2-9]/
  FORMAT = '(%<area>s) %<exchange>s-%<line>s'
  private_constant :Slice,
                   :NANP,
                   :NORTH_AMERICAN_NUMBERING_PLAN,
                   :DIGITS,
                   :VALID_CODE_START,
                   :FORMAT
  
  def self.clean(phone_number)
    new(phone_number).number
  rescue *Errors::ALL
    nil
  end
  
  private
  
  attr_accessor :area,
                :exchange,
                :line
  def initialize(phone_number)
    digits = phone_number.scan(DIGITS).join
    case digits.size
    in 10
      digits
    in 11 if digits.start_with?('1')
      digits
    in 11
      raise Errors::CountryCode, "invalid country code #{digits[0]}"
    else
      raise Errors::Length, "expected 10 or 11 digits, got #{digits.size}"
    end
    self.area     = NANP[:area].of(digits)
    self.exchange = NANP[:exchange].of(digits)
    self.line     = NANP[:line].of(digits)
    raise Errors::AreaCode, "area code cannot start with #{area[0]}" unless
          area[0] =~ VALID_CODE_START
    raise Errors::Exchange, "exchange code cannot start with #{exchange[0]}" unless
          exchange[0] =~ VALID_CODE_START
  end
  
  public
  
  def number
    "#{area}#{exchange}#{line}"
  end
  
  def to_s
    format(FORMAT, area: area, exchange: exchange, line: line)
  end
  
end
