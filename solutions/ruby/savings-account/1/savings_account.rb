class SavingsAccount

  PREMIUM  = ->(balance) { balance >= 5_000 }
  GOLD     = ->(balance) { balance >= 1_000 }
  STANDARD = ->(balance) { balance >= 0 }
  NEGATIVE = ->(_balance) { true }

  INTEREST_RATES = [
    [PREMIUM,  2.475],
    [GOLD,     1.621],
    [STANDARD, 0.5],
    [NEGATIVE, 3.213]
  ]
  private_constant :PREMIUM,
                   :GOLD,
                   :STANDARD,
                   :NEGATIVE,
                   :INTEREST_RATES
  class << self
    def interest_rate balance
      new(balance).interest_rate
    end

    def annual_balance_update balance
      new(balance).annual_update!.amount
    end

    def years_before_desired_balance current_balance, desired_balance
      new(current_balance).years_to reach: desired_balance
    end
  end

  private

  attr_writer :amount

  def initialize amount
    self.amount = amount
  end

  public

  attr_reader :amount

  def interest_rate
    INTEREST_RATES.each do |threshold, rate|
      return rate if threshold.call amount
    end
  end

  def annual_update!
    self.amount += amount * interest_rate/100
    self
  end

  def years_to reach:
    years = 0
    loop do
      break years if amount >= reach
      annual_update!
      years += 1
    end
  end

  def to_s
    'Balance: %.2f at %s%% interest' % [amount, interest_rate]
  end

end
