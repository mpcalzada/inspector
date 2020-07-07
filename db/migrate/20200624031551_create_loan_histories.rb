class CreateLoanHistories < ActiveRecord::Migration[5.2]
  def change
    create_table :loan_histories do |t|
      t.date :paid_date
      t.string :amount, :null => false, :default => '0'
      t.string :interest, :null => false, :default => '0'
      t.integer :paid_type, :null => false, :default => 1
      t.string :remaining_amount, :null => false, :default => '0'

      t.belongs_to :loan, index: true

      t.timestamps
    end
  end
end
