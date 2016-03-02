class ChangeDateFormatForTransactions < ActiveRecord::Migration
  def up
    change_column :transactions, :date, :datetime
  end
  def dowm
    change_column :transactions, :date, :date
  end
end
