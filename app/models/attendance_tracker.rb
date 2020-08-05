class AttendanceTracker < ApplicationRecord
  belongs_to :employer

  ENTRANCE_IDENTIFIER = 'entrada internet 21'
  EXIT_IDENTIFIER = 'salida internet 21'
  ENTRANCE_TIME = '09:00:00'
  DELAY_TIME = '09:10:00'
  EXIT_TIME = '19:00:00'

  def self.full_analysis(initial_date, end_date, employer_id = nil)
    initial_date ||= 15.days.ago.to_date
    end_date ||= Date.today
    attendance_historic = {initial_date: initial_date, end_date: end_date}
    attendance_historic["employers"] ||= []

    employers = employer_id.nil? ? Employer.all : Employer.where(id: employer_id)

    employers.each do |employer|
      attendance = self.date_range_analysis(
          initial_date: initial_date,
          end_date: end_date,
          employer_id: employer.id
      )
      json = {
          employer_id: employer.id,
          employer_name: employer.full_name,
          attendance_tracking: JSON.parse(attendance)
      }
      attendance_historic["employers"] << json
    end

    return attendance_historic.to_json
  end

  def self.date_range_analysis(initial_date: 15.days.ago.to_date, end_date: Date.today, employer_id: nil)
    begin
      response_hash = Hash.new

      is_working = false
      last_entrance = Date.new

      attendances = AttendanceTracker
                        .where(
                            :description => [ENTRANCE_IDENTIFIER, EXIT_IDENTIFIER],
                            :employer_id => employer_id
                        )
                        .where("registered_datetime > ? AND registered_datetime < ?", initial_date, end_date)
                        .order(:registered_datetime)
                        .limit(nil)
      current_day = attendances.first.registered_datetime.wday

      attendances.each do |attend|
        if attend.description.eql? ENTRANCE_IDENTIFIER
          unless is_working && current_day.eql?(attend.registered_datetime.wday)
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
        current_day = attend.registered_datetime.wday
      end
    rescue Exception => e
      puts "Unable to process attendance analysis: #{(e)}"
    end
    return response_hash.values.to_json
  end


  class InnerAttendantControl

    def initialize(date, entrance_time, finished_time, worked_hours, exit_diff = '0')
      @date = date
      @entrance_time = entrance_time.strftime('%H:%M:%S')
      @finished_time = finished_time.strftime('%H:%M:%S')
      @worked_hours = worked_hours.round 2
      @entrance_diff = time_difference(@entrance_time, ENTRANCE_TIME)
      @delay_diff = time_difference(@entrance_time, DELAY_TIME)
      @exit_diff = exit_diff
    end

    def add_minutes(hours)
      @worked_hours = (@worked_hours + hours).round 2
    end

    def change_finished_time(finished_time)
      @finished_time = finished_time.strftime('%H:%M:%S')
      @exit_diff = time_difference(@finished_time, EXIT_TIME)
    end

    def time_difference(date_a, date_b)
      time_a = Time.parse(date_a)
      time_b = Time.parse(date_b)

      seconds = (time_a - time_b).to_f.round(2)

      total_minutes = seconds.abs / 60
      hour = total_minutes / 60
      minutes = total_minutes % 60
      sign = seconds < 0 ? '-' : '+'

      sign + hour.to_i.to_s + ':' + minutes.to_i.abs.to_s
    end
  end

end
