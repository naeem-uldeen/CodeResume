class PhoneNumber

  NANP = NORTH_AMERICAN_NUMBERING_PLAN = {
    country:    [-11, 1],
    area:       [-10, 3],
    exchange:   [-7,  3],
    subscriber: [-4,  4]
  }
  DIGITS      = /[0-9]/
  VALID_START = /[2-9]/
  private_constant :DIGITS,
                   :VALID_START,
                   :NANP

  def self.clean(input)
    new(input).to_s
  rescue LengthError,
         CountryCodeError,
         AreaCodeError,
         ExchangeError
  end

  private

  attr_accessor(*%i[
    area
    exchange
    subscriber
  ])

  def initialize(input)
    digits = input.scan(DIGITS).join
    case digits.size
    when 11
      raise CountryCodeError, '11-digit numbers must start with 1, got %s' % digits[0] unless
        digits.start_with?('1')
      digits = digits.slice(1..)
    when 10
      # already the right length
    else
      raise LengthError, 'invalid length: got %d digits, expected 10 or 11' % digits.size
    end
    self.area       = digits.slice(*NANP[:area])
    self.exchange   = digits.slice(*NANP[:exchange])
    self.subscriber = digits.slice(*NANP[:subscriber])
    raise AreaCodeError, 'area code cannot start with 0 or 1, got %s' % self.area[0] unless
      self.area[0] =~ VALID_START
    raise ExchangeError, 'exchange cannot start with 0 or 1, got %s' % self.exchange[0] unless
      self.exchange[0] =~ VALID_START
  end

  public

  def to_s
    self.area + self.exchange + self.subscriber
  end

  def format
    '(%<area>s) %<exchange>s-%<subscriber>s' % {
      area:       self.area,
      exchange:   self.exchange,
      subscriber: self.subscriber
    }
  end

  class LengthError      < ArgumentError; end
  class CountryCodeError < ArgumentError; end
  class AreaCodeError    < ArgumentError; end
  class ExchangeError    < ArgumentError; end

end

if $PROGRAM_NAME == __FILE__
  def test(input, expected)
    result   = PhoneNumber.clean(input)
    status   = { true => 'PASS', false => 'FAIL' }[result == expected]
    friendly = input.to_s.ljust(22)
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
    puts '  %s => %s' % [n.inspect.ljust(18), phone.format]
  end
  ['(223) 456-7890'].each do |n|
    phone = PhoneNumber.new(n) rescue next
    puts '  %s => %s' % [n.inspect.ljust(18), phone.format]
  end

  puts '%s' % ["\nException detail examples:"]
  begin
    PhoneNumber.new('123456789')
  rescue PhoneNumber::LengthError => e
    puts '  LengthError      | message: %s' % [e.message]
  end
  begin
    PhoneNumber.new('(023) 456-7890')
  rescue PhoneNumber::AreaCodeError => e
    puts '  AreaCodeError    | message: %s' % [e.message]
  end
  begin
    PhoneNumber.new('(223) 056-7890')
  rescue PhoneNumber::ExchangeError => e
    puts '  ExchangeError    | message: %s' % [e.message]
  end
  begin
    PhoneNumber.new('22234567890')
  rescue PhoneNumber::CountryCodeError => e
    puts '  CountryCodeError | message: %s' % [e.message]
  end

end
