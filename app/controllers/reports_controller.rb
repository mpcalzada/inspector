class ReportsController < ApplicationController
  def attendance_tracking
  end

  def accountancy

  end

  def accountancy_partial
    @report_type = params[:id]
  end
end
