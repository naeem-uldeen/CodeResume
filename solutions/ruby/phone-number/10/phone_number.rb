class PhoneNumber

  Slice = Struct.new(:start, :slice_length)

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

  def self.clean(phone_number)
    new(phone_number).to_s
  rescue LengthError, CountryCodeError, AreaCodeError, ExchangeError
    nil
  end

  def initialize(phone_number)
    digits = phone_number.scan(DIGITS).join

    digits =
      case {size: digits.size, first_digit: digits[0]}
      in {size: 11, first_digit: '1'}
        digits.slice(1..)
      in {size: 11, first_digit:}
        raise CountryCodeError.new(first_digit)
      in {size: 10}
        digits # already the right length
      else
        raise LengthError.new(digits.size)
      end

    self.area     = digits.slice(NANP[:area].start, NANP[:area].slice_length)
    self.exchange = digits.slice(NANP[:exchange].start, NANP[:exchange].slice_length)
    self.line     = digits.slice(NANP[:line].start, NANP[:line].slice_length)

    raise AreaCodeError.new(area[0]) unless
      area[0] =~ VALID_CODE_START
    raise ExchangeError.new(exchange[0]) unless
      exchange[0] =~ VALID_CODE_START
  end

  private

  attr_accessor :area,
                :exchange,
                :line

  public

  def to_s
    "#{area}#{exchange}#{line}"
  end

  def format
    FORMAT % {area:, exchange:, line:}
  end

  class LengthError < ArgumentError
    def initialize(digit_count = nil)
      message = digit_count.nil? ? 'invalid length' :
        'invalid length: got %<digit_count>d digits, expected 10 or 11' % {digit_count:}
      super(message)
    end
  end

  class CountryCodeError < ArgumentError
    def initialize(country_digit = nil)
      message = country_digit.nil? ? 'invalid country code' :
        '11-digit numbers must start with 1, got %<country_digit>s' % {country_digit:}
      super(message)
    end
  end

  class AreaCodeError < ArgumentError
    def initialize(leading_digit = nil)
      message = leading_digit.nil? ? 'invalid area code' :
        'area code cannot start with 0 or 1, got %<leading_digit>s' % {leading_digit:}
      super(message)
    end
  end

  class ExchangeError < ArgumentError
    def initialize(leading_digit = nil)
      message = leading_digit.nil? ? 'invalid exchange code' :
        'exchange cannot start with 0 or 1, got %<leading_digit>s' % {leading_digit:}
      super(message)
    end
  end
end

if $PROGRAM_NAME == __FILE__
  def test(actual, expected)
    result = PhoneNumber.clean(actual)
    status = {true => 'PASS', false => 'FAIL'}[result == expected]
    puts '%s | %-24p => %p' % [status, actual, result]
  end

  test '2234567890',       '2234567890'
  test '223.456.7890',     '2234567890'
  test '223 456   7890',   '2234567890'
  test '123456789',        nil
  test '22234567890',      nil
  test '12234567890',      '2234567890'
  test '+1 (223) 456-7890','2234567890'
  test '321234567890',     nil
  test '523-abc-7890',     nil
  test '523-@:!-7890',     nil
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

  puts "\nDefault-message examples (calling .new with no argument):"
  [PhoneNumber::LengthError, PhoneNumber::CountryCodeError, PhoneNumber::AreaCodeError, PhoneNumber::ExchangeError].each do |klass|
    puts '  %s | message: %s' % [klass, klass.new.message]
  end
  
end
