class CreateCreditLines < ActiveRecord::Migration
  def change
    create_table :credit_lines do |t|
      t.float :apr
      t.float :limit
      t.float :amount_drawn

      t.timestamps null: false
    end
  end
end
