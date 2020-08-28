json.extract! account, :id, :name, :description, :account_number, :current_balance, :monthly_income, :monthly_withdrawal, :account_type_id, :created_at, :updated_at
json.url account_url(account, format: :json)
