class LoansController < ApplicationController
  before_action :set_loan, only: [:show, :edit, :update, :destroy, :penalize]

  # GET /loans
  # GET /loans.json
  def index
    @active_loans = Loan.where(:paid => false)
    @inactive_loans = Loan.where(:paid => true)
    @today_loans = Loan.where(:loan_date => Date.today)
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
    @loan = Loan.new(loan_params)
    @loan.amount = @loan.amount.gsub('$', '').gsub(',', '')
    @loan.total_amount = @loan.total_amount.gsub('$', '').gsub(',', '')

    respond_to do |format|
      if @loan.save

        params[:histories].each { |history|
          puts "Loading history: #{history[1]}"
          history[1].permit!
          loan_history = LoanHistory.new(history[1])
          loan_history.paid_type = 1
          loan_history.loan_id = @loan.id
          loan_history.save!
        }

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
    penalization_duty = @loan.total_amount.to_i * 0.10
    @loan.penalization_duty += penalization_duty
    @loan.total_amount = @loan.total_amount
  end

  def pay
    @loan = Loan.find(params[:pay_loan_id])
    @loan.amount_paid = @loan.amount_paid.to_f + params[:pay_amount].to_f

    respond_to do |format|
      if @loan.save!

        @loan_history = LoanHistory.new(
            paid_date: Date.now,
            amount: params[:pay_amount],
            paid_type: '1'
        )

        format.html { redirect_to loans_path, notice: 'Loan was successfully updated.' }
        format.json { render :index, status: :ok, location: @loan }
      else
        format.html { render :index }
        format.json { render json: @loan.errors, status: :unprocessable_entity }
      end
    end

  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_loan
    @loan = Loan.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def loan_params
    params.require(:loan).permit(:employer_id, :amount, :monthly_term, :interest_rate, :total_amount, :loan_date,
                                 :amount_paid, :current_month, :pay_loan_id, :total_interest, :pay_amount, :monthly_payment,
                                 histories: [])
  end
end
