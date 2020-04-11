class CreateClients < ActiveRecord::Migration[6.0]
  def change
    create_table :clients do |t|
      t.string :office_number
      t.date :member_since
      t.belongs_to :person, index:true

      t.timestamps
    end
  end
end
