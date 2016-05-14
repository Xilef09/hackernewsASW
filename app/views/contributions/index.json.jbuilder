json.array!(@contributions) do |contribution|
  json.extract! contribution, :id, :titulo, :user_id, :url, :puntos, :tipo, :text
  json.extract! getAuthor(comment.user_id), :name
end
