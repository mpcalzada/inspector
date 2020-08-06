class AddUniqueIndexToAttendance < ActiveRecord::Migration[5.2]
  def change
    add_index :attendance_trackers, [:employer_id, :registered_datetime],
              unique: true,
              name: 'unique_register_datetime_for_attendance'
  end
end
