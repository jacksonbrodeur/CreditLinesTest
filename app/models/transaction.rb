class Transaction < ActiveRecord::Base
  validates :amount, :numericality => {:greater_than_or_equal_to => 0}, :presence => true

  validate :amount_valid_for_credit_limit

  def amount_valid_for_credit_limit
    @credit_line = CreditLine.find(self.credit_line_id)
    if self.amount.nil?
      return
    end
    if self.transaction_type.eql?("Payment")
      if self.amount > @credit_line.amount_drawn
        errors.add(:base, "You can not payback more than what you have withdrawn")
      end
    else
      if @credit_line.limit < self.amount + @credit_line.amount_drawn
        errors.add(:base, "This withdrawal would put you over your limit")
      end
    end
  end
end
