json.array!(@comments) do |comment|
  json.extract! comment, :id, :user_id, :text, :puntos, :created_at, :contribution_id 
  json.url comment_url(comment, format: :json)
end
