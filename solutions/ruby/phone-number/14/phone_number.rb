class PhoneNumber

  ERRORS = [
    LengthError      = ArgumentError.clone,
    CountryCodeError = ArgumentError.clone,
    AreaCodeError    = ArgumentError.clone,
    ExchangeError    = ArgumentError.clone
  ]
  Slice = Struct.new(:start, :slice_length) do
    def of(string)
      string.slice(start, slice_length)
    end
  end

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
  rescue *ERRORS
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

    self.area     = NANP[:area].of(digits)
    self.exchange = NANP[:exchange].of(digits)
    self.line     = NANP[:line].of(digits)

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

end
