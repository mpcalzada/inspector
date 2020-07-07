json.extract! loan, :id, :employer_id, :amount, :monthly_term, :interest, :total_amount, :loan_date, :amount_paid, :current_month, :created_at, :updated_at
json.url loan_url(loan, format: :json)
