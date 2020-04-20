class CreateUploadFiles < ActiveRecord::Migration[5.0]
  def change
    create_table :upload_files do |t|
      t.belongs_to :user , index:true
      t.attachment :file

      t.timestamps null: false
    end
  end
end
