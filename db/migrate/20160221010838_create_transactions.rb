class CreateTransactions < ActiveRecord::Migration
  def change
    create_table :transactions do |t|
      t.string :transaction_type
      t.integer :credit_line_id
      t.float :amount
      t.date :date

      t.timestamps null: false
    end
  end
end
