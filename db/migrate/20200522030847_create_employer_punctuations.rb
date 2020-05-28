class CreateEmployerPunctuations < ActiveRecord::Migration[5.0]
  def change
    create_table :employer_punctuations do |t|
      t.integer :performance
      t.integer :punctuality
      t.integer :attendance
      t.integer :attitude
      t.integer :quality

      t.belongs_to :employer, index: true

      t.timestamps
    end
  end
end
