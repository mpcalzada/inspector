class CreatePeople < ActiveRecord::Migration[6.0]
  def change
    create_table :people do |t|
      t.string :surname
      t.string :lastname
      t.date :birthday
      t.string :rfc
      t.string :phone_number
      t.string :email
      t.belongs_to :address, index:true

      t.timestamps
    end
  end
end
