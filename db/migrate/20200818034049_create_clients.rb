class CreateClients < ActiveRecord::Migration[5.2]
  def change
    create_table :clients do |t|
      t.boolean :is_buisiness_entity
      t.string :full_name
      t.string :city
      t.string :address
      t.string :contact_email
      t.string :contact_phone

      t.timestamps
    end
  end
end
