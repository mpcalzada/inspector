class AccountancyReportsController < ApplicationController
  def index
  end

  def report_partial
    @report_type = params[:id]
  end
end
