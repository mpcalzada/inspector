class UploadFilesController < ApplicationController
  before_action :set_upload_file, only: [:show, :edit, :update, :destroy]

  @@user ="Upload Files"
  @@byUpload ="Upload Files"
  # GET /upload_files
  # GET /upload_files.json
  def index

    @page = "Upload Files"
    @action = "3"
    @account = "not yet"
    @lasac = "not available"
    @cli_id = 0
    @description = UploadFile.all.count.to_i
    @date = Time.now

    @users = User.all

    @upload_files = UploadFile.page(params[:page]).per(20)


  end

  # GET /upload_files/1
  # GET /upload_files/1.json
  def show


    @page = "Upload Files"
    @action = "5"
    @account = "not yet"
    @lasac = "not available"
    @cli_id = 0
    @date = Time.now


    if @cu != 0

      @per = Profile.where("name = 'Upload Files' and nameProfile_id = ?", @cu)

      if @per.nil?
        @per.each do |permisos|
          @uno = permisos.name
          @crearUpload = permisos.crear
          @editarUpload = permisos.editar
          @leerUpload = permisos.leer
          @eliminarUpload = permisos.eliminar

          if permisos.name == @@byUpload

            @@crear = permisos.crear
            @@editar = permisos.editar
            @@leer = permisos.leer
            @@eliminar = permisos.eliminar

            @crear = permisos.name
            @editar = permisos.editar
            @leer = permisos.leer
            @eliminar = permisos.eliminar
          end

        end

        if ((@@leer == 2))
        else
          @Without_Permission = 100
          redirect_to home_index_path, :alert => t('all.not_access')
        end
      else
        @Without_Permission = 100
        redirect_to home_index_path, :alert => t('all.not_access')
      end
    else
      @Without_Permission = 100
      redirect_to new_user_session_path, :alert => t('all.please_continue')
    end
  end

  # GET /upload_files/new
  def new

    @upload_file = UploadFile.new
    @upload_files = UploadFile.all
  end

  # GET /upload_files/1/edit
  def edit
    if @cu != 0

      @per = Profile.where("name = 'Upload Files' and nameProfile_id = ?", @cu)

      if @per.nil?
        @per.each do |permisos|
          @uno = permisos.name
          @crearUpload = permisos.crear
          @editarUpload = permisos.editar
          @leerUpload = permisos.leer
          @eliminarUpload = permisos.eliminar

          if permisos.name == @@byUpload

            @@crear = permisos.crear
            @@editar = permisos.editar
            @@leer = permisos.leer
            @@eliminar = permisos.eliminar

            @crear = permisos.name
            @editar = permisos.editar
            @leer = permisos.leer
            @eliminar = permisos.eliminar
          end

        end

        if ((@@editar == 4))
        else
          @Without_Permission = 100
          redirect_to home_index_path, :alert => t('all.not_access')
        end
      else
        @Without_Permission = 100
        redirect_to home_index_path, :alert => t('all.not_access')
      end
    else
      @Without_Permission = 100
      redirect_to new_user_session_path, :alert => t('all.please_continue')
    end

  end

  # POST /upload_files
  # POST /upload_files.json
  def create

      @page = "Upload Files"
      @action = "1"
      @account = "not yet"
      @lasac = "not available"
      @cli_id = 0
      @date = Time.now


      @upload_file = UploadFile.create(upload_file_params)
      @upload_file.user = current_user

      respond_to do |format|
        if @upload_file.save

          Read.process(@upload_file.file.path, @upload_file)

          format.html { redirect_to @upload_file, notice: 'Upload file was successfully created.' }
          format.json { render :show, status: :created, location: @upload_file }
        else
          format.html { render :new }
          format.json { render json: @upload_file.errors, status: :unprocessable_entity }
        end
      end
  end

  # PATCH/PUT /upload_files/1
  # PATCH/PUT /upload_files/1.json
  def update
    if current_user

      @page = "Upload Files"
      @action = "2"
      @account = "not yet"
      @lasac = "not available"
      @cli_id = 0
      @date = Time.now

      @historic = Historic.new
      @historic.page = @page
      @historic.user = @user + " " + @userl
      @historic.user_id = @user_id
      @historic.action = @action
      @historic.account = @account
      @historic.last_account = @lasac
      @historic.date = @date

      respond_to do |format|
        if @upload_file.update(upload_file_params)
          @historic.detail = @upload_file.to_json
          @historic.save
          format.html { redirect_to @upload_file, notice: 'Upload file was successfully updated.' }
          format.json { render :show, status: :ok, location: @upload_file }
        else
          format.html { render :edit }
          format.json { render json: @upload_file.errors, status: :unprocessable_entity }
        end
      end
    else
      @Without_Permission = 100
      redirect_to new_user_session_path, :alert => t('all.please_continue')
    end

  end

  # DELETE /upload_files/1
  # DELETE /upload_files/1.json
  def destroy

    @page = "Upload Files"
    @action = "4"
    @account = "not yet"
    @lasac = "not available"
    @cli_id = 0
    @date = Time.now

    @historic = Historic.new
    @historic.page = @page
    @historic.user = @user + " " + @userl
    @historic.user_id = @user_id
    @historic.action = @action
    @historic.account = @account
    @historic.last_account = @lasac
    @historic.date = @date
    @historic.save

    if @cu != 0

      @per = Profile.where("name = 'Upload Files' and nameProfile_id = ?", @cu)

      if @per.nil?
        @per.each do |permisos|
          @uno = permisos.name
          @crearUpload = permisos.crear
          @editarUpload = permisos.editar
          @leerUpload = permisos.leer
          @eliminarUpload = permisos.eliminar

          if permisos.name == @@byUpload

            @@crear = permisos.crear
            @@editar = permisos.editar
            @@leer = permisos.leer
            @@eliminar = permisos.eliminar

            @crear = permisos.name
            @editar = permisos.editar
            @leer = permisos.leer
            @eliminar = permisos.eliminar
          end

        end

        if ((@@eliminar == 1))

          @upload_file.destroy
          respond_to do |format|
            @historic.detail = @upload_file.to_json
            @historic.save
            format.html { redirect_to upload_files_url, notice: 'Upload file was successfully destroyed.' }
            format.json { head :no_content }
          end
        else
          @Without_Permission = 100
          redirect_to home_index_path, :alert => t('all.not_access')
        end

      else
        @Without_Permission = 100
        redirect_to home_index_path, :alert => t('all.not_access')
      end
    else
      @Without_Permission = 100
      redirect_to new_user_session_path, :alert => t('all.please_continue')
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_upload_file
    @upload_file = UploadFile.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def upload_file_params
    params.require(:upload_file).permit(:file, :user_id)
  end

end
