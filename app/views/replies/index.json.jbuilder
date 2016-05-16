json.array!(@replies) do |reply|
  json.extract! reply, :id, :content, :puntos, :created_at, :user_id, :comment_id
  json.hal reply_url(reply)
end
