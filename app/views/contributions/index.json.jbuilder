json.array!(@contributions) do |contribution|
  json.extract! contribution, :id, :titulo, :user_id, :url, :puntos, :text, :created_at
  json.url contribution_url(contribution, format: :json)
end
