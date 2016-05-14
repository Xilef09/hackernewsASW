json.array!(@comments) do |comment|
  json.extract! comment, :id,:content, :puntos, :created_at
  json.url comment_url(comment, format: :json)
end