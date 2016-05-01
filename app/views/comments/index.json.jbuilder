json.array!(@comments) do |comment|
  json.extract! comment, :id, :content, :puntos
  json.url comment_url(comment, format: :json)
end
