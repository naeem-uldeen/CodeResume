module SavingsAccountConveniences

  def interest_rate balance
    new(balance).interest_rate
  end

  def annual_balance_update balance
    new(balance).annual_update!.amount
  end

  def years_before_desired_balance current_balance, goal
    new(current_balance).years_to_reach goal: goal
  end

end

class SavingsAccount
  extend SavingsAccountConveniences

  PLAN = {
    premium:  { threshold: ->(balance) { balance >= 5_000 }, rate: 2.475 },
    gold:     { threshold: ->(balance) { balance >= 1_000 }, rate: 1.621 },
    standard: { threshold: ->(balance) { balance >= 0     }, rate: 0.5   },
    overdrawn:{ threshold: ->(balance) { balance < 0      }, rate: 3.213 },
  }
  private_constant :PLAN

  private

  attr_writer :amount

  def initialize amount
    self.amount = amount
  end

  public

  attr_reader :amount

  def interest_rate
    _plan, tier = PLAN.find { |_plan, tier| tier[:threshold].call amount }
    tier[:rate]
  end

  def annual_update!
    self.amount += amount * interest_rate / 100
    self
  end

  def years_to_reach goal:
    for years in 0..Float::INFINITY
      break years if amount >= goal
      annual_update!
    end
  end

  def to_s
    'Balance: %.2<amount>f at %.3<interest_rate>f%% interest' % {amount:, interest_rate:}
  end

end

if $PROGRAM_NAME == __FILE__
  my_savings = SavingsAccount.new(1_000)
  puts my_savings
  puts 'Interest rate: %.3f%%'        % my_savings.interest_rate
  puts 'Balance after one year: %.2f' % my_savings.annual_update!.amount
  puts 'Years to reach 10_000: %d'    % my_savings.years_to_reach(goal: 10_000)
end
