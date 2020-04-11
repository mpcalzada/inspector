json.extract! person, :id, :surname, :lastname, :birthday, :rfc, :phone_number, :email, :address_id, :created_at, :updated_at
json.url person_url(person, format: :json)
