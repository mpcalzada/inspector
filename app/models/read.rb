class Read

  require 'roo'

  def self.processFileData(ruta, upload_file)
    file = Roo::Excelx.new(ruta)

    row_number = 1

    file.each do |hash|

      row_number = row_number.to_i + 1

      employer_name = file.cell(row_number, 'A')
      employer_id = file.cell(row_number, 'B').to_i
      registered_time = file.cell(row_number, 'C')
      description = file.cell(row_number, 'D')

      unless employer_id.nil?

        begin


          @employer = Employer.where(:identification_number => employer_id).first
          user_id = nil
          if @employer.nil?
            puts "Unable to find employer #{employer_name} with identifier #{employer_id} for row number #{row_number} in file #{ruta}"
          else
            user_id = @employer.id
            AttendanceTracker.new(
                :name => employer_name.downcase,
                :description => description.downcase,
                :employer_id => @employer.id,
                :registered_datetime => registered_time,
                :internal_id => employer_id
            ).save
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
  end

end