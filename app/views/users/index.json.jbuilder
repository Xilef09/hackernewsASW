json.array!(@users) do |user|
  json.extract! user, :id, :name, :password, :created_at, :karma, :about, :email
  json.url user_url(user, format: :json)
end
