json.array!(@comments) do |comment|
  json.extract! comment, :id, :user.id,:content, :puntos, :created_at
  json.url comment_url(comment, format: :json)
end