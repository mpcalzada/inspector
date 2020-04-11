class Read

  require 'roo'

  def self.process(ruta, upload_file)
    file = Roo::Excelx.new(ruta)

    row_number = 1

    file.each do |hash|

      row_number = row_number.to_i + 1

      employer_name = file.cell(row_number, 'A')
      employer_id = file.cell(row_number, 'B').to_i
      registered_time = file.cell(row_number, 'C')
      description = file.cell(row_number, 'D')

      unless employer_name.nil?

        begin

          employer_name = employer_name.gsub(/\s+/, '')

          if employer_name.include? '-'
            employer_name = employer_name.gsub '-', '.'
          end

          first_name = employer_name.split('.')[0]
          last_name = employer_name.split('.')[1]

          first_name = first_name.nil? ? '' : first_name.downcase
          last_name = last_name.nil? ? '' : last_name.downcase

          @user = Employer.where(
              'REPLACE(lower(first_name), \' \', \'\') = ? and REPLACE(lower(last_name), \' \', \'\') = ?',
              first_name,
              last_name
          ).first

          user_id = @user.nil? ? 0 : @user.id

          AttendanceTracker.new(
              :name => employer_name.downcase,
              :description => description.downcase,
              :user_id => user_id,
              :registered_datetime => registered_time,
              :internal_id => employer_id
          ).save
        rescue Exception => e
          puts('Unable to write AttendanceTracker for '+
                   "Employer Name: #{(employer_name)}"+
                   "Description: #{(description)}"+
                   "User Id: #{(user_id)}"+
                   "Registered Datetime: #{(registered_time)}"+
                   "Internal Id: #{(employer_id)}"+
                   "Exception: #{(e.message)}"
          )
        end

      end

    end

    #UploadFileMailer.alert_confirmation(upload_file, @@y, @@save, @@c).deliver

  end

end