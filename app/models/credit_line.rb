class CreditLine < ActiveRecord::Base
  has_many :transactions
  validates :apr, :limit, :numericality => {:greater_than_or_equal_to => 0}, :presence => true
  after_initialize :default_values

  private
    def default_values
      self.amount_drawn ||= 0
      self.interest ||= 0
    end
end
