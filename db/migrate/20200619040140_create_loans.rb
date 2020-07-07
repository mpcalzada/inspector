class CreateLoans < ActiveRecord::Migration[5.2]
  def change
    create_table :loans do |t|
      t.string :amount
      t.integer :monthly_term
      t.float :interest
      t.string :total_amount
      t.date :loan_date
      t.string :amount_paid, :null => false, :default => 0
      t.integer :current_month, :null => false, :default => 0

      t.belongs_to :employer, index: true

      t.timestamps
    end
  end
end
