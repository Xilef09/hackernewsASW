json.array!(@contributions) do |contribution|
  json.extract! contribution, :id, :titulo, :user_id, :url, :puntos, :comentarios, :tipo, :text
  json.url contribution_url(contribution, format: :json)
end
