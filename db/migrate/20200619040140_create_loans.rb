class CreateLoans < ActiveRecord::Migration[5.2]
  def change
    create_table :loans do |t|
      t.string :monthly_payment
      t.string :amount
      t.string :total_amount
      t.string :total_interest
      t.integer :penalization_duty, :null => false, :default => 0
      t.integer :prepayment_amount, :null => false, :default => 0
      t.integer :monthly_term
      t.float :interest_rate
      t.date :loan_date, :null => false
      t.string :amount_paid, :null => false, :default => 0
      t.integer :current_month, :null => false, :default => 0
      t.boolean :paid, :null => false, :default => false

      t.belongs_to :employer, index: true

      t.timestamps
    end
  end
end
