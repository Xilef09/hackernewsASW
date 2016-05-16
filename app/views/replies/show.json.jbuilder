json.extract! @reply, :id, :content, :puntos, :user_id, :comment_id, :contribution_id,  :created_at, :user_id, :comment_id
json.hal reply_url(@reply)