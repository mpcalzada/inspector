json.extract! employer, :id, :first_name, :last_name, :birthday, :rfc, :phone_number, :email, :salary, :contract_number, :street, :city, :state, :country, :cp, :created_at, :updated_at
json.url employer_url(employer, format: :json)
