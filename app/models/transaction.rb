class Transaction < ActiveRecord::Base
  validates :amount, :numericality => {:greater_than_or_equal_to => 0}, :presence => true

  validate :amount_valid_for_credit_limit, :date_valid

  def amount_valid_for_credit_limit
    credit_line = CreditLine.find(self.credit_line_id)
    if self.amount.nil?
      return
    end
    if self.transaction_type.eql?("Payment")
      if self.amount > credit_line.amount_drawn
        errors.add(:base, "You can not payback more than what you have withdrawn")
      end
    else
      if credit_line.limit < self.amount + credit_line.amount_drawn
        errors.add(:base, "This withdrawal would put you over your limit")
      end
    end
  end

  def date_valid
    credit_line = CreditLine.find(self.credit_line_id)
    transactions = credit_line.transactions
    if self.date.to_datetime.mjd >= transactions.first.date.to_datetime.mjd + 30
      errors.add(:date, "is outside of the 30 day period (#{transactions.first.date.to_date} - #{transactions.first.date.to_date + 30})")
    elsif self.date.to_datetime.mjd <= transactions.last.date.to_datetime.mjd
      errors.add(:date, "is before the last transaction made (#{transactions.last.date.to_date})" )
    end
  end
end
