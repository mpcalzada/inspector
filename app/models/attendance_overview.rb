class AttendanceOverview < ApplicationRecord
  belongs_to :employer
  validates_uniqueness_of :date, scope: [:employer_id]

  ENTRANCE_TIME = Time.parse("09:00:00")
  EXIT_TIME = Time.parse("18:00:00")

  def self.delayed_employers_track(top = 10, initial_date = Date.today.at_beginning_of_month.last_month)
    return employers_overview_track(top, true, initial_date)
  end

  def self.on_time_employers_track(top = 10, initial_date = Date.today.at_beginning_of_month.last_month)
    return employers_overview_track(top, false, initial_date)
  end

  def self.employers_overview_track(top, is_delayed = true, initial_date)
    overview = Hash.new
    attendance_overview = AttendanceOverview
                              .joins(:employer)
                              .where(:is_delayed => is_delayed)
                              .where("date > ?", initial_date)
                              .group(%w[employers.first_name employers.paternal_last_name])
                              .order("count_all DESC")
                              .limit(top)
                              .count

    attendance_overview.each do |key, val|
      overview[key[0] + " " + key[1]] = val
    end
    return overview
  end

  def self.grouped_by_month(is_delayed, initial_date = Date.today.beginning_of_month.last_year)
    formatted_hash = {}
    attendance_overview = AttendanceOverview
                              .where(:is_delayed => is_delayed)
                              .where("date > ?", initial_date)
                              .group("date_trunc('month', date)")
                              .count

    attendance_overview.each { |k, v| formatted_hash[k.strftime('%b %Y')] = v }
    return add_months formatted_hash, initial_date, Date.today.end_of_month
  end

  def self.add_tracker(initial_date, end_date)
    query = "SELECT date_trunc('day', registered_datetime) \"day\", employer_id, count(*) \"moves\",
min(registered_datetime) min_time, max(registered_datetime) max_time
FROM attendance_trackers
WHERE registered_datetime between '#{initial_date.to_time.strftime("%Y-%m-%d %H:%M:%S")}' AND '#{end_date.to_time.strftime("%Y-%m-%d %H:%M:%S")}'
GROUP BY day, employer_id"

    results = ActiveRecord::Base.connection.execute(query)


    results.each do |result|
      begin
        half_moves = (result["moves"] / 2).ceil

        formatted_entry_time = result["min_time"].to_time.strftime('%H:%M:%S')
        formatted_exit_time = result["max_time"].to_time.strftime('%H:%M:%S')

        attendance_overview = AttendanceOverview.new(
            :date => result["day"],
            :entrance_time => result["min_time"],
            :exit_time => result["max_time"],
            :is_delayed => (estimate_delay formatted_entry_time),
            :worked_hours => (time_difference formatted_exit_time, formatted_entry_time),
            :registered_entries => half_moves,
            :registered_exits => half_moves,
            :entry_time_difference => (time_difference formatted_entry_time, "09:00:00"),
            :exit_time_difference => (time_difference formatted_exit_time, "18:00:00"),
            :employer_id => result["employer_id"]
        )
        unless attendance_overview.save!
          puts "Unable to save the attendance overview object #{attendance_overview}"
        end
      rescue Exception => e
        puts "Error trying to save #{attendance_overview} because of #{e}"
      end
    end
  end

  def self.estimate_delay(entrance_time)
    time_a = Time.parse(entrance_time)
    time_b = Time.parse('09:10:00')

    ((time_a - time_b).to_f.round(2) > 0)
  end

  def self.time_difference(date_a, date_b)
    time_a = Time.parse(date_a)
    time_b = Time.parse(date_b)

    seconds = (time_a - time_b).to_f.round(2)

    total_minutes = seconds.abs / 60
    hour = total_minutes / 60
    minutes = total_minutes % 60
    sign = seconds < 0 ? '-' : ''

    '%s%02d:%02d' % [sign, hour.to_i, minutes.to_i.abs]
  end

  private

  def self.add_months(dates, initial_date, end_date)
    range = (initial_date..end_date).map { |date| date.strftime("%b %Y") }.uniq

    range.each_with_object({}) { |date, result| result[date] = dates[date] || 0 }
  end
end
