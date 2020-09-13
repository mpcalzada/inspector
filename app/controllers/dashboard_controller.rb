class DashboardController < ApplicationController
  def home_dashboard
  end

  def attendance_dashboard
    @top_delayed = AttendanceTracker.top(:delayed)
    @top_punctual = AttendanceTracker.top(:punctual)
  end

  def accountancy_dashboard
    @active_loans_total = Loan.active.count
    @inactive_loans_total = Loan.inactive.count
    @total_loaned_amount = Loan.active.sum(:total_amount)
  end

  def human_resources_dashboard
  end

  def reports_dashboard
  end
end
