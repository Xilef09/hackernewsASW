json.array!(@comments) do |comment|
  json.extract! comment, :id, :content, :puntos, :created_at, :user_id, :contribution_id, :replies
  json.hal comment_url(comment)
end