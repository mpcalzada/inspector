class CreateEmployers < ActiveRecord::Migration[6.0]
  def change
    create_table :employers do |t|
      t.string :first_name
      t.string :last_name
      t.date :birthday
      t.string :rfc
      t.string :phone_number
      t.string :email
      t.float :salary
      t.string :contract_number
      t.string :street
      t.string :city
      t.string :state
      t.string :country
      t.string :cp

      t.belongs_to :user, index:true
      t.belongs_to :degree, index:true
      t.timestamps
    end
  end
end
