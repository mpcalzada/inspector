class Read

  require 'roo'

  def self.process_attendance_sheet(ruta, upload_file)
    file = Roo::Excelx.new(ruta)
    existing_employers = Employer.pluck(:identification_number).map { |s| s.to_i }
    row_number = 1

    file_init_date = nil
    file_end_date = nil

    file.each do |hash|

      row_number = row_number.to_i + 1

      employer_name = file.cell(row_number, 'A')
      employer_id = file.cell(row_number, 'B')
      registered_time = file.cell(row_number, 'C')
      description = file.cell(row_number, 'D')

      unless employer_id.nil?
        user_id = nil
        begin
          if existing_employers.include? employer_id
            employer_id = employer_id
            @employer = Employer.where(:identification_number => employer_id).first
            user_id = @employer.id

            file_init_date = registered_time if file_init_date.nil? or file_init_date > registered_time
            file_end_date = registered_time if file_end_date.nil? or file_end_date < registered_time

            attendance_tracker = AttendanceTracker.new(
                :name => employer_name.downcase,
                :description => description.downcase,
                :employer_id => @employer.id,
                :registered_datetime => registered_time,
                :internal_id => employer_id
            )
            attendance_tracker.save
          else
            puts "Unable to find employer #{employer_name} with identifier #{employer_id} for row number #{row_number} in file #{ruta}"
          end
        rescue Exception => e
          puts('Unable to write AttendanceTracker for ' +
                   "Employer Name: #{(employer_name)}" +
                   "Description: #{(description)}" +
                   "Employer Id: #{(user_id)}" +
                   "Registered Datetime: #{(registered_time)}" +
                   "Internal Id: #{(employer_id)}" +
                   "Exception: #{(e.message)}"
          )
        end

      end
    end

    AttendanceOverview.add_tracker file_init_date, file_end_date
  end

end