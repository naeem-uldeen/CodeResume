class PhoneNumber

  DIGITS         = /[0-9]/
  VALID_START    = /[2-9]/
  COUNTRY_CODE   = '1'

  NANP_COMPONENTS = {
    area_code:         [0, 3],
    exchange_code:     [3, 3],
    subscriber_number: [6, 4]
  }

  MESSAGES = {
    invalid_length:      'invalid length',
    country_code:        '11-digit numbers must start with 1',
    area_code_start:     'area code cannot start with 0 or 1',
    exchange_code_start: 'exchange code cannot start with 0 or 1'
  }

  private_constant :DIGITS,
                   :VALID_START,
                   :COUNTRY_CODE,
                   :NANP_COMPONENTS,
                   :MESSAGES

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

  def initialize(raw_digits)
    normalized = raw_digits.scan(DIGITS).join
    normalized = case normalized.size
                 when 11 then raise InvalidPhoneNumber.new(:country_code) unless
                    normalized.start_with?(COUNTRY_CODE)
                  normalized.slice(1..)
                  when 10 then normalized
                  else raise InvalidPhoneNumber.new(:invalid_length)
                  end
    self.area_code         = normalized.slice(*NANP_COMPONENTS[:area_code])
    self.exchange_code     = normalized.slice(*NANP_COMPONENTS[:exchange_code])
    self.subscriber_number = normalized.slice(*NANP_COMPONENTS[:subscriber_number])
    self.digits            = area_code + exchange_code + subscriber_number

    raise InvalidPhoneNumber.new(:area_code_start)     unless
      area_code[0]     =~ VALID_START
    raise InvalidPhoneNumber.new(:exchange_code_start) unless
      exchange_code[0] =~ VALID_START
  end

  public

  def cleaned
    digits
  end

  def to_s
  '(%<area_code>s) %<exchange_code>s-%<subscriber_number>s' % {
    area_code: area_code,
    exchange_code: exchange_code,
    subscriber_number: subscriber_number
  }

end

  class InvalidPhoneNumber < ArgumentError
    def initialize(reason)
      super(MESSAGES[reason])
    end
  end

end

if $PROGRAM_NAME == __FILE__
  def self.test(input, expected)
    result   = PhoneNumber.clean(input)
    status   = result == expected ? 'PASS' : 'FAIL'
    friendly = input.inspect.ljust(22)
    puts "#{status} | #{friendly} => #{result.inspect}"
  rescue PhoneNumber::InvalidPhoneNumber => e
    puts "ERROR | #{input.inspect} => #{e.message}"
  end

  test '2234567890',         '2234567890'
  test '223-456-7890',       '2234567890'
  test '(223) 456-7890',     '2234567890'
  test '223.456.7890',       '2234567890'
  test '223 456 7890',       '2234567890'
  test '+1 223 456 7890',    '2234567890'
  test '1 (223) 456-7890',   '2234567890'
  test '123456789',          nil
  test '(023) 456-7890',     nil
  test '(123) 456-7890',     nil
  test '(223) 056-7890',     nil
  test '(223) 156-7890',     nil
  test '22234567890',        nil

  puts "\nFormatted examples:"
  ['2234567890', '223-456-7890', '(223) 456-7890'].each do |n|
    phone = PhoneNumber.new(n) rescue next
    puts "  #{n.inspect.ljust(18)} => #{phone.to_s}"
  end
end
