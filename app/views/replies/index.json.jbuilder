json.array!(@replies) do |reply|
  json.extract! reply, :id
  json.url reply_url(reply, format: :json)
end
