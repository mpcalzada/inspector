class HomeController < ApplicationController

  def index
    delayed_group = AttendanceOverview.grouped_by_month true
    on_time_group = AttendanceOverview.grouped_by_month false
    @searched_months = delayed_group.map { |k, v| k }
    @delayed_punctuations = delayed_group.map { |k, v| v }
    @on_time_punctuations = on_time_group.map { |k, v| v }

    @active_loans_total = Loan.active.count
    @inactive_loans_total = Loan.inactive.count
    @total_loaned_amount = Loan.active.sum(:total_amount)
  end

end