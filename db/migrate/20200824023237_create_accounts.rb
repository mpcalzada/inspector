class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :description
      t.string :account_number
      t.decimal :current_balance, :precision => 8, :scale => 2, :null => false, :default => 0
      t.decimal :monthly_income, :precision => 8, :scale => 2, :null => false, :default => 0
      t.decimal :monthly_withdrawal, :precision => 8, :scale => 2, :null => false, :default => 0
      t.belongs_to :account_type, index: true

      t.timestamps
    end
  end
end
