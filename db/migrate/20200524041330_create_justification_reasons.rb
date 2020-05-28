class CreateJustificationReasons < ActiveRecord::Migration[5.0]
  def change
    create_table :justification_reasons do |t|
      t.string :description

      t.timestamps
    end
  end
end
