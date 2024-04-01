module SavingsAccount
  def self.interest_rate(balance)
    return 3.213 if balance < 0
    return 0.5 if balance < 1000
    return 1.621 if balance >= 1000 and balance < 5000
    return 2.475 if balance >= 5000
  end

  def self.annual_balance_update(balance)
    interest_rate = SavingsAccount.interest_rate(balance) / 100
    balance + (balance * interest_rate)
  end

  def self.years_before_desired_balance(current_balance, desired_balance)
    balance = current_balance
    years = 0

    until balance > desired_balance do
      balance = annual_balance_update(balance)
      years = years + 1
    end

    years
  end
end
