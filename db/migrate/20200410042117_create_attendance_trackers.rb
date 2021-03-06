class CreateAttendanceTrackers < ActiveRecord::Migration[5.0]
  def change
    create_table :attendance_trackers do |t|
      t.belongs_to :employer, index: true
      t.belongs_to :justification_reason, index: true

      t.string :name
      t.integer :internal_id
      t.string :description
      t.string :justification_description
      t.datetime :registered_datetime

      t.timestamps
    end
  end
end
