class PhoneNumber

  DIGITS               = /[0-9]/
  INVALID_START_DIGITS = /[01]/
  private_constant :DIGITS, :INVALID_START_DIGITS

  def self.clean(digits)
    new(digits).cleaned
  rescue InvalidPhoneNumber
    nil
  end

  private

  attr_accessor :digits,
                :area_code,
                :exchange_code,
                :subscriber_number

  def initialize(digits)
    cleaned = digits.scan(DIGITS).join

    case cleaned.size
    when 11
      raise InvalidPhoneNumber.new(:country_code) unless cleaned.start_with?('1')
      cleaned = cleaned.slice(1..)
    when 10
      # valid length, continue
    else
      raise InvalidPhoneNumber.new(:invalid_length)
    end

    self.digits            = cleaned
    self.area_code         = cleaned.slice(0, 3)
    self.exchange_code     = cleaned.slice(3, 3)
    self.subscriber_number = cleaned.slice(6, 4)

    raise InvalidPhoneNumber.new(:area_code_start)     if
      area_code.slice(0)     =~ INVALID_START_DIGITS
    raise InvalidPhoneNumber.new(:exchange_code_start) if
      exchange_code.slice(0) =~ INVALID_START_DIGITS
  end

  public

  def cleaned
    area_code + exchange_code + subscriber_number
  end

  class InvalidPhoneNumber < ArgumentError
    MESSAGES = {
      invalid_length:      'invalid length',
      country_code:        '11-digit numbers must start with 1',
      area_code_start:     'area code cannot start with 0 or 1',
      exchange_code_start: 'exchange code cannot start with 0 or 1'
    }

    def initialize(reason)
      super(MESSAGES[reason])
    end
  end
end

if $PROGRAM_NAME == __FILE__
  puts PhoneNumber.clean('2234567890')               # => 2234567890
  puts PhoneNumber.clean('223-456-7890')             # => 2234567890
  puts PhoneNumber.clean('(223) 456-7890')           # => 2234567890
  puts PhoneNumber.clean('223.456.7890')             # => 2234567890
  puts PhoneNumber.clean('223 456 7890')             # => 2234567890
  puts PhoneNumber.clean('+1 223 456 7890')          # => 2234567890
  puts PhoneNumber.clean('1 (223) 456-7890')         # => 2234567890
  puts PhoneNumber.clean('123456789').inspect        # => nil
  puts PhoneNumber.clean('(023) 456-7890').inspect   # => nil
  puts PhoneNumber.clean('(123) 456-7890').inspect   # => nil
  puts PhoneNumber.clean('(223) 056-7890').inspect   # => nil
  puts PhoneNumber.clean('(223) 156-7890').inspect   # => nil
  puts PhoneNumber.clean('22234567890').inspect      # => nil
end
