json.array!(@replies) do |reply|
  json.extract! reply, :id, :content, :puntos
  json.url reply_url(reply, format: :json)
end
