json.extract! contact, :id, :name, :line1, :line2, :city, :state, :zip, :phone, :created_at, :updated_at
json.url contact_url(contact, format: :json)