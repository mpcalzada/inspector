module EmployersHelper

  def time_formatter (time)
    time.nil? ? '12:00' : DateTime.parse(time.to_s).strftime('%H:%M')
  end
end
