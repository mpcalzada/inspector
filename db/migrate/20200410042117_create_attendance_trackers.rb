class CreateAttendanceTrackers < ActiveRecord::Migration[6.0]
  def change
    create_table :attendance_trackers do |t|
      t.belongs_to :users , index:true

      t.integer :user_id
      t.string :name
      t.integer :internal_id
      t.string :description
      t.datetime :registered_datetime

      t.timestamps
    end
  end
end
