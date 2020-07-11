class CreateLoanHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :loan_histories do |t|
      t.date :paid_date, :null => false
      t.decimal :amount, :precision => 8, :scale => 2, :null => false
      t.integer :paid_type, :null => false
      t.decimal :remaining_amount, :precision => 8, :scale => 2, :null => false

      t.belongs_to :loan, index: true

      t.timestamps
    end
  end
end
