json.array!(@comments) do |comment|
  json.extract! comment, :id, :content, :puntos, :created_at, :user_id, :contribution_id
  json.url comment_url(comment, format: :json)
end