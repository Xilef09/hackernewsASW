json.extract! @reply, :id, :content, :puntos, :user_id, :comment_id, :contribution_id,  :created_at, :user_id, :comment_id
json.url reply_url(reply, format: :json)