class AttendanceOverview < ApplicationRecord
  def self.add_tracker(initial_date, end_date)
    attendance_trackers = AttendanceTracker
                              .where("registered_datetime >= ? AND registered_datetime =< ?", initial_date, end_date)

  end
end
