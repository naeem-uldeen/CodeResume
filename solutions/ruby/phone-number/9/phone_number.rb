class PhoneNumber
  
  Slice = Struct.new(:start, :length)

  NANP = NORTH_AMERICAN_NUMBERING_PLAN = {
    country:  Slice.new(-11, 1),
    area:     Slice.new(-10, 3),
    exchange: Slice.new( -7, 3),
    line:     Slice.new( -4, 4)
  }
  DIGITS = /[0-9]/
  VALID_CODE_START = /[2-9]/
  FORMAT = '(%<area>s) %<exchange>s-%<line>s'
  private_constant :Slice,
                    :NANP,
                    :NORTH_AMERICAN_NUMBERING_PLAN,
                    :DIGITS,
                    :VALID_CODE_START,
                    :FORMAT

  def self.clean(input)
    new(input).to_s
  rescue LengthError,
         CountryCodeError,
         AreaCodeError,
         ExchangeError
  end

  private

  attr_accessor :area,
                :exchange,
                :line

  def initialize(input)
    digits = input.scan(DIGITS).join

    digits =
      case { size: digits.size, first_digit: digits[0] }
      in { size: 11, first_digit: '1' }
        digits.slice(1..)
      in { size: 11, first_digit: }
        raise CountryCodeError, first_digit
      in { size: 10 }
        digits # already the right length
      else
        raise LengthError, 'invalid length: got %d digits, expected 10 or 11' % digits.size
      end

    self.area     = digits.slice(*NANP[:area])
    self.exchange = digits.slice(*NANP[:exchange])
    self.line     = digits.slice(*NANP[:line])

    raise AreaCodeError, area[0] unless
      area[0] =~ VALID_CODE_START
    raise ExchangeError, exchange[0] unless
      exchange[0] =~ VALID_CODE_START
  end

  public

  def to_s
    "#{area}#{exchange}#{line}"
  end

  def format
    FORMAT % { area:, exchange:, line: }
  end

  class LengthError < ArgumentError; end

  class CountryCodeError < ArgumentError
    def initialize(country_digit)
      super('11-digit numbers must start with 1, got %<country_digit>s' % { country_digit: country_digit })
    end
  end

  class AreaCodeError < ArgumentError
    def initialize(leading_digit)
      super('area code cannot start with 0 or 1, got %<leading_digit>s' % { leading_digit: leading_digit })
    end
  end

  class ExchangeError < ArgumentError
    def initialize(leading_digit)
      super('exchange cannot start with 0 or 1, got %<leading_digit>s' % { leading_digit: leading_digit })
    end
  end
end

if $PROGRAM_NAME == __FILE__
  def test(actual, expected)
    result = PhoneNumber.clean(actual)
    status = { true => 'PASS', false => 'FAIL' }[result == expected]
    puts '%s | %-24p => %p' % [status, actual, result]
  end

  test '2234567890',       '2234567890'
  test '223-456-7890',     '2234567890'
  test '(223) 456-7890',   '2234567890'
  test '223.456.7890',     '2234567890'
  test '223 456 7890',     '2234567890'
  test '+1 223 456 7890',  '2234567890'
  test '1 (223) 456-7890', '2234567890'
  test '123456789',        nil
  test '(023) 456-7890',   nil
  test '(123) 456-7890',   nil
  test '(223) 056-7890',   nil
  test '(223) 156-7890',   nil
  test '22234567890',      nil

  puts "\nFormatted examples:"
  ['2234567890', '223-456-7890', '(223) 456-7890'].each do |n|
    phone = PhoneNumber.new(n) rescue next
    puts '  %-18p => %s' % [n, phone.format]
  end

  puts "\nException detail examples:"
  ['123456789', '(023) 456-7890', '(223) 056-7890', '22234567890'].each do |number|
    PhoneNumber.new(number)
  rescue PhoneNumber::LengthError,
         PhoneNumber::AreaCodeError,
         PhoneNumber::ExchangeError,
         PhoneNumber::CountryCodeError => e
    puts '  %s | message: %s' % [e.class, e.message]
  end
  
end
