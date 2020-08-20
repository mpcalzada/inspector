json.extract! client, :id, :is_buisiness_entity, :full_name, :city, :address, :contact_email, :contact_phone, :created_at, :updated_at
json.url client_url(client, format: :json)
