class AddInterestToCreditLines < ActiveRecord::Migration
  def change
    add_column :credit_lines, :interest, :float
  end
end
