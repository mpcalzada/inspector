class EmployersController < ApplicationController
  before_action :set_employer, only: [:show, :edit, :update, :destroy, :attach_document, :enable_user, :add_roles]

  @employers_hash = %w[employer_admin employer_editor employer_viewer]

  # GET /employers
  # GET /employers.json
  def index
    @employers = Employer.all.order(:first_name)
  end

  # GET /employers/1
  # GET /employers/1.json
  def show
    @attendance_report = AttendanceTracker.perform_attendance_analysis
    @roles = EmployerRoles.new

    user = @employer.user

    unless user.nil?
      @roles.general = 'admin' if user.has_role? :admin
      @roles.employer = 'employer_viewer' if user.has_role? :employer_admin
      @roles.employer = 'employer_editor' if user.has_role? :employer_editor
      @roles.employer = 'employer_admin' if user.has_role? :employer_admin
    end
  end

  def attach_document

    case params[:document_type]
    when '1'
      @employer.scholarship_attachments.attach(params[:attachment])
    when '2'
      @employer.master_attachments.attach(params[:attachment])
    when '3'
      @employer.phd_attachments.attach(params[:attachment])
    when '4'
      @employer.courses_attachments.attach(params[:attachment])
    else
      format.html { redirect_to @employer, notice: 'No se pudo crear el documento.' }
      format.json { render json: @employer.errors, status: :unprocessable_entity }
    end

    respond_to do |format|
      if @employer.save
        format.html { redirect_to @employer, notice: 'Employer was successfully created.' }
        format.json { render :show, status: :created, location: @employer }
      else
        format.html { render :new }
        format.json { render json: @employer.errors, status: :unprocessable_entity }
      end
    end
  end

  def enable_user

    username = @employer.first_name + '.' + @employer.paternal_last_name + '.' + @employer.maternal_last_name
    user = User.new({
                        :username => username.gsub(/\s+/, "").downcase,
                        :email => @employer.email,
                        :password => params[:password],
                        :password_confirmation => params[:password_confirmation]
                    })

    respond_to do |format|
      if user.save

        @employer.user_id = user.id

        if @employer.save
          format.html { redirect_to @employer, notice: 'Employer was successfully created.' }
          format.json { render :show, status: :created, location: @employer }
        else
          format.html { render @employer }
          format.json { render json: @employer.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to @employer, notice: user.errors }
        format.json { render json: user.errors, status: :unprocessable_entity }
      end
    end
  end

  def add_roles
    user = @employer.user

    params[:input_roles].each_pair { |role_name, value|
      case role_name

      when 'general'
        case value
        when 'admin'
          user.add_role :admin
        else
          user.remove_role :admin
        end
      when 'employers'
        EmployersController.modify_role(value, 'employer', user)
      else
        puts "Unknown role definition for #{role_name} value: #{value}"
      end
    }

    respond_to do |format|
      if user.save
        format.html { redirect_to @employer, notice: 'Employer was successfully created.' }
        format.json { render :show, status: :created, location: @employer }
      else
        format.html { redirect_to @employer, notice: user.errors }
        format.json { render json: user.errors, status: :unprocessable_entity }
      end
    end

  end

  def self.modify_role (role_exempt, type, user)
    if type == 'employer'
      @employers_hash.each do |value|
        if value == role_exempt
          user.add_role value
        else
          user.remove_role value
        end
      end
    end
  end

  # GET /employers/new
  def new
    @employer = Employer.new
  end

  # GET /employers/1/edit
  def edit
  end

  # POST /employers
  # POST /employers.json
  def create
    @employer = Employer.new(employer_params)

    respond_to do |format|
      if @employer.save
        format.html { redirect_to @employer, notice: 'Employer was successfully created.' }
        format.json { render :show, status: :created, location: @employer }
      else
        format.html { render :new }
        format.json { render json: @employer.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employers/1
  # PATCH/PUT /employers/1.json
  def update
    respond_to do |format|
      if @employer.update(employer_params)
        format.html { redirect_to @employer, notice: 'Employer was successfully updated.' }
        format.json { render :show, status: :ok, location: @employer }
      else
        format.html { render :edit }
        format.json { render json: @employer.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employers/1
  # DELETE /employers/1.json
  def destroy
    @employer.destroy
    respond_to do |format|
      format.html { redirect_to employers_url, notice: 'Employer was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_employer
    @employer = Employer.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def employer_params
    params.require(:employer).permit(
        :first_name, :paternal_last_name, :maternal_last_name, :gender, :birthday, :avatar,
        :curriculum_vitae, :rfc, :curp, :scholarship, :courses_description, :phone_number,
        :home_number, :email, :personal_email, :contract_number, :gross_salary, :net_salary,
        :entry_date, :validity, :insurance_number, :street, :city, :state, :country, :postal_code,
        :chief_id, :user_id, :degree_id, :nationality, :marital_status, :personal_phone_number,
        :home_type, :home_financial_type, :entrance_time, :exit_time, :travel_capability,
        :dependents_number, :blood_type, :allergies, :contact1_full_name, :contact1_relationship,
        :contact1_home_phone_number, :contact1_cellphone_number, :contact2_full_name,
        :contact2_relationship, :contact2_home_phone_number, :contact2_cellphone_number,
        :masters_description, :phd_description, :birthplace_country, :birthplace_city, :diseases, :password,
        :identification_number, scholarship_attachments: [], master_attachments: [], phd_attachments: [], input_roles: []
    )
  end
end
