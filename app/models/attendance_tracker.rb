class AttendanceTracker < ApplicationRecord
  belongs_to :employer

  validates_uniqueness_of :registered_datetime, scope: [:employer_id]

  def self.perform_attendance_analysis(employer)
    begin
      entrance_constant = 'entrada internet 21'
      exit_constant = 'salida internet 21'
      response_hash = Hash.new

      is_working = false
      last_entrance = Date.new

      attendances = AttendanceTracker.where(:description => [entrance_constant, exit_constant], :employer_id => employer.id).order(:registered_datetime).limit(nil)

      attendances.each do |attend|
        if attend.description.eql? entrance_constant
          unless is_working
            is_working = true
            last_entrance = attend.registered_datetime
          end
        else
          if is_working
            is_working = false
            last_exit = attend.registered_datetime

            key = attend.registered_datetime.strftime('%m-%d-%Y')
            worked_hours = ((last_exit - last_entrance) / 60) / 60

            if response_hash.key? key
              inner_attendant_control = response_hash[key]
              inner_attendant_control.change_finished_time last_exit
              inner_attendant_control.add_minutes worked_hours
            else
              inner_attendant_control = InnerAttendantControl.new(key, last_entrance, last_exit, worked_hours)
            end

            response_hash[key] = inner_attendant_control
          end
        end
      end
    rescue Exception => e
      puts "Unable to process attendance analysis: #{(e)}"
    end
    return response_hash.values.to_json
  end

  class InnerAttendantControl

    def initialize(date, entrance_time, finished_time, worked_hours)
      @date = date
      @entrance_time = entrance_time.strftime('%H:%M:%S')
      @finished_time = finished_time.strftime('%H:%M:%S')
      @worked_hours = worked_hours.round 2
    end

    def add_minutes(hours)
      @worked_hours = (@worked_hours + hours).round 2
    end

    def change_finished_time(finished_time)
      @finished_time = finished_time.strftime('%H:%M:%S')
    end
  end
end
