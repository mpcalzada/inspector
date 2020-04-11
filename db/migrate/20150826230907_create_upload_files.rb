class CreateUploadFiles < ActiveRecord::Migration[5.0]
  def change
    create_table :upload_files do |t|
      t.belongs_to :users , index:true
      t.integer :user_id
      t.attachment :file

      t.timestamps null: false
    end
  end
end
