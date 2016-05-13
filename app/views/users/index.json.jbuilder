json.array!(@users) do |user|
  json.extract! user, :id, :user, :password, :created, :karma, :about, :email
  json.url user_url(user, format: :json)
end
