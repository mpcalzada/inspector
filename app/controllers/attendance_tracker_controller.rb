class AttendanceTrackerController < ApplicationController
  before_action :set_attendance_tracker, only: [:update]

  # PATCH/PUT /attendance_tracker/1
  # PATCH/PUT /attendance_tracker/1.json
  def update
    respond_to do |format|
      if @attendance_tracker.update(attendance_tracker_params)
        format.html { redirect_to degrees_path, notice: 'Tttendance Tracker was successfully updated.' }
        format.json { render :index, status: :ok, location: @attendance_tracker }
      else
        format.html { render :edit }
        format.json { render json: @attendance_tracker.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /attendance_tracker/1
  # DELETE /attendance_tracker/1.json
  def destroy
    @attendance_tracker.destroy
    respond_to do |format|
      format.html { redirect_to degrees_url, notice: 'Degree was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_attendance_tracker
    @attendance_tracker = AttendanceTracker.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def attendance_tracker_params
    params.require(:attendance_tracker).permit(:description, :department_id)
  end
end