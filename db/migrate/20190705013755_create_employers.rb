class CreateEmployers < ActiveRecord::Migration[6.0]
  def change
    create_table :employers do |t|
      t.float :salary
      t.string :contract_number
      t.belongs_to :degree, index:true
      t.belongs_to :person, index:true

      t.timestamps
    end
  end
end
