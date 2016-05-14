json.array!(@replies) do |reply|
  json.extract! reply, :id, :content, :puntos, :created_at, :user_id, :comment_id
  json.url reply_url(reply, format: :json)
end
