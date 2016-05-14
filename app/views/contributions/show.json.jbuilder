json.extract! @contribution, :id, :titulo, :user_id, :url, :puntos, :text, :created_at
json.extract! #getAuthor(comment.user_id), :name