class PhoneNumber
  
  DIGITS      = /[0-9]/
  VALID_START = /[2-9]/

  NANP_COMPONENTS = {
    country:    [-11, 1],
    area:       [-10, 3],
    exchange:   [-7,  3],
    subscriber: [-4,  4]
  }

  private_constant :DIGITS,
                   :VALID_START,
                   :NANP_COMPONENTS

  def self.clean(input)
    new(input).cleaned
  rescue InvalidLength,
         InvalidCountryCode,
         InvalidAreaCode,
         InvalidExchange
  end

  private

  attr_accessor *%i[
    area
    exchange
    subscriber
  ]

  def initialize(input)
    digits = input.scan(DIGITS).join

    case digits.size
    when 11
      raise InvalidCountryCode.new(digits[0]) unless digits.start_with?('1')
      digits = digits.slice(1..)
    when 10
      # already the right length
    else
      raise InvalidLength.new(digits.size)
    end

    self.area       = digits.slice(*NANP_COMPONENTS[:area])
    self.exchange   = digits.slice(*NANP_COMPONENTS[:exchange])
    self.subscriber = digits.slice(*NANP_COMPONENTS[:subscriber])

    raise InvalidAreaCode.new(self.area[0])     unless self.area[0]     =~ VALID_START
    raise InvalidExchange.new(self.exchange[0]) unless self.exchange[0] =~ VALID_START
  end

  public

  def cleaned
    self.area + self.exchange + self.subscriber
  end

  def to_s
    '(%<area>s) %<exchange>s-%<subscriber>s' % {
      area:       self.area,
      exchange:   self.exchange,
      subscriber: self.subscriber
    }
  end

  class InvalidLength < ArgumentError
    attr_accessor :digit_count

    def initialize(digit_count)
      self.digit_count = Integer(digit_count)
      super('invalid length: got %d digits, expected 10 or 11' % [digit_count])
    end
  end

  class InvalidCountryCode < ArgumentError
    attr_accessor :country_digit

    def initialize(country_digit)
      self.country_digit = String(country_digit)
      super('11-digit numbers must start with 1, got %<country_digit>s' % { country_digit: country_digit })
    end
  end

  class InvalidAreaCode < ArgumentError
    attr_accessor :leading_digit

    def initialize(leading_digit)
      self.leading_digit = String(leading_digit)
      super('area code cannot start with 0 or 1, got %<leading_digit>s' % { leading_digit: leading_digit })
    end
  end

  class InvalidExchange < ArgumentError
    attr_accessor :leading_digit

    def initialize(leading_digit)
      self.leading_digit = String(leading_digit)
      super('exchange cannot start with 0 or 1, got %<leading_digit>s' % { leading_digit: leading_digit })
    end
  end
end

if $PROGRAM_NAME == __FILE__
  def self.test(input, expected)
    result   = PhoneNumber.clean(input)
    status   = result == expected ? 'PASS' : 'FAIL'
    friendly = input.inspect.ljust(22)
    puts '%s | %s => %s' % [status, friendly, result.inspect]
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

  puts '%s' % ["\nFormatted examples:"]
  %w[2234567890 223-456-7890].each do |n|
    phone = PhoneNumber.new(n) rescue next
    puts '  %s => %s' % [n.inspect.ljust(18), phone.to_s]
  end
  ['(223) 456-7890'].each do |n|
    phone = PhoneNumber.new(n) rescue next
    puts '  %s => %s' % [n.inspect.ljust(18), phone.to_s]
  end

  puts '%s' % ["\nException detail examples:"]
  begin
    PhoneNumber.new('123456789')
  rescue PhoneNumber::InvalidLength => e
    puts '  InvalidLength   | message: %s'     % [e.message]
    puts '                  | digit_count: %d' % [e.digit_count]
  end

  begin
    PhoneNumber.new('(023) 456-7890')
  rescue PhoneNumber::InvalidAreaCode => e
    puts '  InvalidAreaCode | message: %s'      % [e.message]
    puts '                  | leading_digit: %s' % [e.leading_digit]
  end

  begin
    PhoneNumber.new('(223) 056-7890')
  rescue PhoneNumber::InvalidExchange => e
    puts '  InvalidExchange | message: %s'      % [e.message]
    puts '                  | leading_digit: %s' % [e.leading_digit]
  end

  begin
    PhoneNumber.new('22234567890')
  rescue PhoneNumber::InvalidCountryCode => e
    puts '  InvalidCountry  | message: %s'      % [e.message]
    puts '                  | country_digit: %s' % [e.country_digit]
  end
end
