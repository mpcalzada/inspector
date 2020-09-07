class AccountancyReportsController < ApplicationController
  def index
  end

  def report_partialmcalar
    @report_type = params[:id]
  end
end
