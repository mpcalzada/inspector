class DashboardController < ApplicationController
  def home_dashboard
  end

  def attendance_dashboard
    delayed_group = AttendanceOverview.grouped_by_month true
    on_time_group = AttendanceOverview.grouped_by_month false

    @period = 1.month.ago
    @top_delayed = AttendanceOverview.delayed_employers_track 10
    @top_punctual = AttendanceOverview.on_time_employers_track 10
    @searched_months = delayed_group.map { |k, v| k }
    @delayed_punctuations = delayed_group.map { |k, v| v }
    @on_time_punctuations = on_time_group.map { |k, v| v }
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
