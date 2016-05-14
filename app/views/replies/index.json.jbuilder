json.array!(@replies) do |reply|
  json.extract! reply, :id, :content, :puntos, :created_at
  json.url reply_url(reply, format: :json)
end
