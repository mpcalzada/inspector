class CreateLoans < ActiveRecord::Migration[5.2]
  def change
    create_table :loans do |t|
      t.decimal :monthly_payment, :precision => 8, :scale => 2
      t.decimal :amount, :precision => 8, :scale => 2
      t.decimal :total_amount, :precision => 8, :scale => 2
      t.decimal :total_interest, :precision => 8, :scale => 2
      t.decimal :amount_paid, :precision => 8, :scale => 2, :null => false
      t.decimal :penalization_duty, :precision => 8, :scale => 2, :null => false, :default => 0
      t.decimal :prepayment_amount, :precision => 8, :scale => 2, :null => false, :default => 0
      t.integer :monthly_term
      t.float :interest_rate
      t.date :loan_date, :null => false
      t.date :next_payment, :null => false
      t.integer :current_month, :null => false, :default => 0
      t.boolean :paid, :null => false, :default => false

      t.belongs_to :employer, index: true

      t.timestamps
    end
  end
end
