class LoansController < ApplicationController
  before_action :set_loan, only: [:show, :edit, :update, :destroy, :penalize, :pay_monthly, :prepayment]

  # GET /loans
  # GET /loans.json
  def index
    @active_loans = Loan.where(:paid => false)
    @inactive_loans = Loan.where(:paid => true)
    @today_loans = Loan.where('next_payment <= ?', Date.today)
  end

  # GET /loans/1
  # GET /loans/1.json
  def show
  end

  # GET /loans/new
  def new
    @loan = Loan.new
  end

  # GET /loans/1/edit
  def edit
  end

  # POST /loans
  # POST /loans.json
  def create
    sanitize_params
    @loan = Loan.new(loan_params)
    @loan.next_payment = @loan.loan_date + 1.month

    respond_to do |format|
      if @loan.save

        format.html { redirect_to @loan, notice: 'Loan was successfully created.' }
        format.json { render :show, status: :created, location: @loan }
      else
        format.html { render :new }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /loans/1
  # PATCH/PUT /loans/1.json
  def update
    respond_to do |format|
      if @loan.update(loan_params)
        format.html { redirect_to @loan, notice: 'Loan was successfully updated.' }
        format.json { render :show, status: :ok, location: @loan }
      else
        format.html { render :edit }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /loans/1
  # DELETE /loans/1.json
  def destroy
    @loan.destroy
    respond_to do |format|
      format.html { redirect_to loans_url, notice: 'Loan was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def penalize
    unless @loan.next_payment > Date.now
      penalization_duty = @loan.total_amount.to_f * 0.05
      @loan.penalization_duty += penalization_duty
      @loan.total_amount += penalization_duty
      @loan.next_payment += 1.month

      if @loan.save
        LoanHistory.new(
            paid_date: Date.today,
            amount: penalization_duty,
            remaining_amount: @loan.total_amount,
            paid_type: LoanHistory::Payment::PENALIZATION,
            loan_id: @loan.id
        ).save!
      end
    end

    redirect_back(fallback_location: loans_path)
  end

  def pay_monthly
    unless @loan.next_payment > Date.today
      @loan.amount_paid += @loan.monthly_payment.to_f
      @loan.total_amount -= @loan.monthly_payment.to_f
      @loan.current_month += 1
      @loan.next_payment += 1.month

      if @loan.save
        LoanHistory.new(
            paid_date: Date.today,
            amount: @loan.monthly_payment,
            remaining_amount: @loan.total_amount,
            paid_type: LoanHistory::Payment::MONTHLY_PAYMENT,
            loan_id: @loan.id
        ).save!
      end
    end

    redirect_back(fallback_location: loans_path)
  end

  def prepayment
    @loan.amount_paid += params[:pay_amount].to_f
    @loan.total_amount -= params[:pay_amount].to_f

    respond_to do |format|
      if @loan.save!

        LoanHistory.new(
            paid_date: Date.today,
            amount: params[:pay_amount].to_f,
            remaining_amount: @loan.total_amount,
            paid_type: LoanHistory::Payment::PREPAYMENT,
            loan_id: @loan.id
        ).save!

        format.html { redirect_to loans_path, notice: 'Loan was successfully updated.' }
        format.json { render :index, status: :ok, location: @loan }
      else
        format.html { render :index }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end

  end

  private

  def sanitize_params
    params[:loan][:amount] = params[:loan][:amount].gsub('$', '').gsub(',', '')
    params[:loan][:total_amount] = params[:loan][:total_amount].gsub('$', '').gsub(',', '')
    params[:loan][:monthly_payment] = params[:loan][:monthly_payment].gsub('$', '').gsub(',', '')
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_loan
    @loan = Loan.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def loan_params
    params.require(:loan).permit(:employer_id, :amount, :monthly_term, :interest_rate, :total_amount, :loan_date,
                                 :amount_paid, :current_month, :total_interest, :pay_amount, :monthly_payment,)
  end
end
