json.extract! user, :id, :email, :full_name, :rut, :created_at, :updated_at
json.url users_url(user, format: :json)
