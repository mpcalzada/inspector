class CreateAttendanceOverviews < ActiveRecord::Migration[5.2]
  def change
    create_table :attendance_overviews do |t|
      t.date :date, null: false
      t.datetime :entrance_time, null: false
      t.datetime :exit_time, null: false
      t.boolean :is_delayed
      t.string :worked_hours
      t.integer :registered_entries
      t.integer :registered_exits
      t.string :entry_time_difference
      t.string :exit_time_difference

      # Is Justified
      t.boolean :is_justified, default: true
      t.string :justification_description

      t.belongs_to :employer, index: true

      t.timestamps
    end

    add_index :attendance_overviews, [:employer_id, :date],
              unique: true,
              name: 'unique_date_for_attendance'
  end
end
